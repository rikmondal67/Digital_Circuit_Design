
#include<iostream>
#include<string>

#include <unordered_map>
using namespace std;
class Solution {
public:

    unordered_map<char,int> mp;

    bool isAnagram(string s, string t) {
        
        for(int i=0;i<s.length();i++){
            mp[s[i]]++;

        }
        for(int i=0;i<t.length();i++){
            mp[t[i]]--;
        }

        for(auto &map:mp){
            cout<<map.second<<endl;
            if(map.second>=0){
                return false;
            }
        }

        

        return true;
        
    }
};

int main(){

    string s="ab";
    string t="a";

    Solution s1;
    cout<<s1.isAnagram(s,t)<<endl;

}