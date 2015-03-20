From: Kamil Debski <k.debski@samsung.com>
Subject: [RFC v3 3/9] Input: add key codes specific to the HDMI CEC bus
Date: Fri, 20 Mar 2015 17:52:37 +0100
Message-ID: <1426870363-18839-4-git-send-email-k.debski@samsung.com>
References: <1426870363-18839-1-git-send-email-k.debski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <1426870363-18839-1-git-send-email-k.debski@samsung.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc: sean@mess.org, mchehab@osg.samsung.com, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, thomas@tommie-lie.de, linux-input@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-input@vger.kernel.org

VGhlIEhETUkgQ0VDIGJ1cyBhbGxvd3MgZGV2aWNlIHRvIGNvbW11bmljYXRlIHdpdGggb25lIGFu
b3RoZXIuClRoaXMgaW5jbHVkZXMgc2VuZGluZyByZW1vdGUgY29udHJvbCBrZXkgY29kZXMuIFNv
bWUgb2Yga2V5IGNvZGVzCmRlZmluZWQgaW4gdGhlIENFQyBzdGFuZGFyZCBhcmUgbm90IGRlZmlu
ZWQgaW4gdGhlIGlucHV0LmguClRoaXMgcGF0Y2ggYWRkcyB0aGUga2V5IGNvZGVzIHRoYXQgYXJl
IG1pc3NpbmcuCgpTaWduZWQtb2ZmLWJ5OiBLYW1pbCBEZWJza2kgPGsuZGVic2tpQHNhbXN1bmcu
Y29tPgotLS0KIGluY2x1ZGUvdWFwaS9saW51eC9pbnB1dC5oIHwgICAxMiArKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91
YXBpL2xpbnV4L2lucHV0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvaW5wdXQuaAppbmRleCBiMGE4
MTMwLi4zZmM2ODg1IDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvaW5wdXQuaAorKysg
Yi9pbmNsdWRlL3VhcGkvbGludXgvaW5wdXQuaApAQCAtNzQ3LDYgKzc0NywxOCBAQCBzdHJ1Y3Qg
aW5wdXRfa2V5bWFwX2VudHJ5IHsKICNkZWZpbmUgS0VZX0tCRElOUFVUQVNTSVNUX0FDQ0VQVAkJ
MHgyNjQKICNkZWZpbmUgS0VZX0tCRElOUFVUQVNTSVNUX0NBTkNFTAkJMHgyNjUKIAorI2RlZmlu
ZSBLRVlfUklHSFRfVVAJCQkweDI2NgorI2RlZmluZSBLRVlfUklHSFRfRE9XTgkJCTB4MjY3Cisj
ZGVmaW5lIEtFWV9MRUZUX1VQCQkJMHgyNjgKKyNkZWZpbmUgS0VZX0xFRlRfRE9XTgkJCTB4MjY5
CisKKyNkZWZpbmUgS0VZX05FWFRfRkFWT1JJVEUJCTB4MjcwCisjZGVmaW5lIEtFWV9TVE9QX1JF
Q09SRAkJCTB4MjcxCisjZGVmaW5lIEtFWV9QQVVTRV9SRUNPUkQJCTB4MjcyCisjZGVmaW5lIEtF
WV9WT0QJCQkJMHgyNzMKKyNkZWZpbmUgS0VZX1VOTVVURQkJCTB4Mjc0CisjZGVmaW5lIEtFWV9E
VkIJCQkJMHgyNzUKKwogI2RlZmluZSBCVE5fVFJJR0dFUl9IQVBQWQkJMHgyYzAKICNkZWZpbmUg
QlROX1RSSUdHRVJfSEFQUFkxCQkweDJjMAogI2RlZmluZSBCVE5fVFJJR0dFUl9IQVBQWTIJCTB4
MmMxCi0tIAoxLjcuOS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
