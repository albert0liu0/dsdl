#include<cstdio>
#include<vector>
using namespace std;
struct form{
    int num[6];
};
void toForm(int n,form *f){
    for(int i=0;i<6;i++)(f->num)[i]=0;
    int idx=0;
    while(n){
	(f->num)[idx]=n%2;
	n/=2;
	idx++;
    }
}
int comForm(form f1,form f2){
    int d=0,idx=-2;
    for(int i=0;i<6;i++){
        if(f1.num[i]!=f2.num[i]){
            if(idx!=-2){
                idx=-1;
                break;
            }
            else idx=i;
        }
    }
    return idx;
}
int valueForm(form f,int n){
    for(int i=0;i<6;i++){
        if(f.num[i]==-1){
            n/=2;continue;
        }
        if(f.num[i]!=n%2)return 0;
        n/=2;
    }
    return 1;
}
/*comForm errorCode:
  -1:differ by 2
  -2:differ by 0
*/
struct map{
    vector<form> pi_list;
    vector<vector<int> >value_list;
};
int rowElimi(map *m){
    int ret=0;
    for(int j=0;j<(m->pi_list).size();j++){
        for(int i=0;i<(m->pi_list).size();i++){
            if(i==j)continue;
            int dom_i=1;
            for(int l=0;l<(m->value_list)[i].size();l++){
                if((m->value_list)[j][l]>(m->value_list)[i][l]){
                    dom_i=0;
                    break;
                }
            }
            if(dom_i){
                ret=1;
                (m->pi_list).erase((m->pi_list).begin()+j);
                (m->value_list).erase((m->value_list).begin()+j);
                j--;
                if(i>j)i--;
                break;
            }
        }
    }
    return ret;
} 
int colElimi(map *m){
    int ret=0;
    for(int i=0;i<(m->value_list)[0].size();i++){
        for(int j=0;j<(m->value_list)[0].size();j++){
            if(i==j)continue;
            int dom_j=1;
            for(int l=0;l<(m->pi_list).size();l++){
                if((m->value_list)[l][i]>(m->value_list)[l][j]){
                    dom_j=0;
                    break;
                }
            }
            if(dom_j){
                ret=1;
                for(int l=0;l<(m->pi_list).size();l++)
                    (m->value_list)[l].erase((m->value_list)[l].begin()+j);
                j--;
                if(i>j)i--;
            }
        }
    }
    return ret;
}
int essAdd(map* m,vector<form>* e,int ess_idx){
    (*e).push_back((m->pi_list)[ess_idx]);
    for(int j=0;j<(m->value_list)[0].size();j++){
        if((m->value_list)[ess_idx][j]){
            for(int l=0;l<(m->pi_list).size();l++)
                (m->value_list)[l].erase((m->value_list)[l].begin()+j);
            j--;
        }
    }
}
int essCheck(map* m,vector<form>* e){
    for(int i=0;i<(m->value_list)[0].size();i++){
        int ess_idx=-1;
        for(int l=0;l<(m->pi_list).size();l++){
            if((m->value_list)[l][i]){
                if(ess_idx!=-1){
                    ess_idx=-1;
                    break;
                }
                else
                    ess_idx=l;
            }
        }
        if(ess_idx>=0){
            essAdd(m,e,ess_idx);
        }
    }
}
int cycAdd(map* m,vector<form>* e){
    essAdd(m,e,(m->pi_list).size()-1);
}
int main(){
    int n;
    scanf("%d",&n);
    int pn=1<<n;
    int nf;scanf("%d",&nf);
    int f[nf];
    for(int i=0;i<nf;i++){
        scanf("%d",&f[i]);
    }
    int nd;scanf("%d",&nd);
    int d[nd];
    for(int i=0;i<nd;i++){
        scanf("%d",&d[i]);
    }
    vector<form>group_size[n+1];
    vector<form>pi;
    for(int i=0;i<nf;i++){
        form tmpf;
        toForm(f[i],&tmpf);
        group_size[0].push_back(tmpf);
    }
    for(int i=0;i<nd;i++){
        form tmpf;
        toForm(d[i],&tmpf);
        group_size[0].push_back(tmpf);
    }
    for(int i=0;i<n;i++){
        for(int j=0;j<group_size[i].size();j++){
            for(int k=j+1;k<group_size[i].size();k++){
                int idx=comForm(group_size[i][j],group_size[i][k]);
                if(idx==-1)continue;
                if(idx==-2){
                    group_size[i].erase(group_size[i].begin()+k);
                    continue;
                }
                form tmpf;
                for(int l=0;l<6;l++)tmpf.num[l]=group_size[i][j].num[l];
                tmpf.num[idx]=-1;
                group_size[i+1].push_back(tmpf);
            }
        }
    }
    for(int i=0;i<=n;i++)for(int j=0;j<group_size[i].size();j++)
        pi.push_back(group_size[i][j]);
    int n_pi=pi.size();
    map m;
    for(int i=0;i<n_pi;i++)m.pi_list.push_back(pi[i]);
    for(int i=0;i<n_pi;i++){
        m.value_list.push_back(vector<int>());
        for(int j=0;j<nf;j++)
            m.value_list[i].push_back(valueForm(m.pi_list[i],f[j]));
    }
    vector<form>ess_pi;
    while(m.value_list[0].size()){
        int check=rowElimi(&m)+colElimi(&m)+essCheck(&m,&ess_pi);
        if(check==0)cycAdd(&m,&ess_pi);
    }
    for(int i=0;i<ess_pi.size();i++){
        for(int j=0;j<n;j++){
            if(ess_pi[i].num[n-j-1]!=-1){
                printf("%c",'a'+j);
                if(ess_pi[i].num[n-j-1]==0)printf("'");
            }
        }
        printf("\n");
    }
}
