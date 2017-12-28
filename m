From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 2/2] arm: dts: sun8i: a83t: a711: Add touchscreen node
Date: Thu, 28 Dec 2017 17:33:36 +0100
Message-ID: <20171228163336.28131-3-mylene.josserand@free-electrons.com>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quentin.schulz@free-electrons.com, linux-input@vger.kernel.org, mylene.josserand@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

VGhhIEE3MTEgdGFibGV0IGhhcyBhIEZvY2FsVGVjaCBFRFQtRlQ1eDA2IFBvbHl0b3VjaCB0b3Vj
aHNjcmVlbi4KSXQgaXMgY29ubmVjdGVkIHZpYSBJMkMwLiBUaGUgcmVzZXQgbGluZSBpcyBQRDUs
IHRoZSBpbnRlcnJ1cHQKbGluZSBpcyBQTDcgYW5kIHRoZSBWQ0Mgc3VwcGx5IGlzIHRoZSBsZG9f
aW8wIHJlZ3VsYXRvci4KClNpZ25lZC1vZmYtYnk6IE15bMOobmUgSm9zc2VyYW5kIDxteWxlbmUu
am9zc2VyYW5kQGZyZWUtZWxlY3Ryb25zLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9zdW44
aS1hODN0LXRicy1hNzExLmR0cyB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAxNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc3VuOGkt
YTgzdC10YnMtYTcxMS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9zdW44aS1hODN0LXRicy1hNzEx
LmR0cwppbmRleCBhMDIxZWU2ZGEzOTYuLjc4NDBmOWFhOTA5NCAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvc3VuOGktYTgzdC10YnMtYTcxMS5kdHMKKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvc3VuOGktYTgzdC10YnMtYTcxMS5kdHMKQEAgLTEwNSw2ICsxMDUsMjIgQEAKIAlzdGF0dXMg
PSAib2theSI7CiB9OwogCismaTJjMCB7CisJY2xvY2stZnJlcXVlbmN5ID0gPDQwMDAwMD47CisJ
c3RhdHVzID0gIm9rYXkiOworCisJdG91Y2hzY3JlZW5AMzggeworCQljb21wYXRpYmxlID0gImVk
dCxlZHQtZnQ1eDA2IjsKKwkJcmVnID0gPDB4Mzg+OworCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZy
X3Bpbz47CisJCWludGVycnVwdHMgPSA8MCA3IElSUV9UWVBFX0VER0VfRkFMTElORz47CisJCXJl
c2V0LWdwaW9zID0gPCZwaW8gMyA1IEdQSU9fQUNUSVZFX0xPVz47CisJCXZjYy1zdXBwbHkgPSA8
JnJlZ19sZG9faW8wPjsKKwkJdG91Y2hzY3JlZW4tc2l6ZS14ID0gPDEwMjQ+OworCQl0b3VjaHNj
cmVlbi1zaXplLXkgPSA8NjAwPjsKKwl9OworfTsKKwogJm1tYzAgewogCXZtbWMtc3VwcGx5ID0g
PCZyZWdfZGNkYzE+OwogCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Ci0tIAoyLjExLjAKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
