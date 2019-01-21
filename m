From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH] input: Fix the CONFIG_SPARC64 mixup
Date: Sun, 20 Jan 2019 17:49:14 -0800
Message-ID: <20190121014914.2328-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: dmitry.torokhov@gmail.com
Cc: y2038@lists.linaro.org, davem@davemloft.net, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

QXJuZCBCZXJnbWFubiBwb2ludGVkIG91dCB0aGF0IENPTkZJR18qIGNhbm5vdCBiZSB1c2VkCmlu
IGEgdWFwaSBoZWFkZXIuIE92ZXJyaWRlIHdpdGggYW4gZXF1aXZhbGVudCBjb25kaXRpb25hbC4K
CkZpeGVzOiAyZTc0Njk0MmViYWMgKCJJbnB1dDogaW5wdXRfZXZlbnQgLSBwcm92aWRlIG92ZXJy
aWRlIGZvciBzcGFyYzY0IikKRml4ZXM6IDE1MjE5NGZlOWMzZiAoIklucHV0OiBleHRlbmQgdXNh
YmxlIGxpZmUgb2YgZXZlbnQgdGltZXN0YW1wcyB0byAyMTA2IG9uIDMyIGJpdCBzeXN0ZW1zIikK
U2lnbmVkLW9mZi1ieTogRGVlcGEgRGluYW1hbmkgPGRlZXBhLmtlcm5lbEBnbWFpbC5jb20+Ci0t
LQogaW5jbHVkZS91YXBpL2xpbnV4L2lucHV0LmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGlu
dXgvaW5wdXQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9pbnB1dC5oCmluZGV4IGZmYWI5NThiYzUx
Mi4uZjA1NmIyYTAwZDVjIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvaW5wdXQuaAor
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvaW5wdXQuaApAQCAtMzIsNyArMzIsNyBAQCBzdHJ1Y3Qg
aW5wdXRfZXZlbnQgewogI2RlZmluZSBpbnB1dF9ldmVudF91c2VjIHRpbWUudHZfdXNlYwogI2Vs
c2UKIAlfX2tlcm5lbF91bG9uZ190IF9fc2VjOwotI2lmZGVmIENPTkZJR19TUEFSQzY0CisjaWYg
ZGVmaW5lZChfX3NwYXJjX18pICYmIGRlZmluZWQoX19hcmNoNjRfXykKIAl1bnNpZ25lZCBpbnQg
X191c2VjOwogI2Vsc2UKIAlfX2tlcm5lbF91bG9uZ190IF9fdXNlYzsKLS0gCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWTIwMzggbWFpbGlu
ZyBsaXN0ClkyMDM4QGxpc3RzLmxpbmFyby5vcmcKaHR0cHM6Ly9saXN0cy5saW5hcm8ub3JnL21h
aWxtYW4vbGlzdGluZm8veTIwMzgK
