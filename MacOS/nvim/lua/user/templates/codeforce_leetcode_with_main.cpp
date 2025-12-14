// Date: %DATE%
// Author: Shashank_V_H

#include <bits/stdc++.h>
using namespace std;

// solution class goes here

int main() {
  int t;
  cin >> t;

  Solution sol;

  while (t--) {
    vector<int> arr;
    int x;

    while (cin >> x) {
      arr.push_back(x);
      if (cin.peek() == '\n')
        break;
    }

    if (sol.function_name(param)) {
      cout << "contains duplicates" << endl;
    } else {
      cout << "doesn't contain duplicates" << endl;
    }
  }

  return 0;
}
