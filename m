From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 08:16:18 -0700
Message-ID: <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="00000000000007413e05795f8e85"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Harry Cutts <hcutts@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, peter.hutterer@who-t.net
List-Id: linux-input@vger.kernel.org

--00000000000007413e05795f8e85
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 29, 2018 at 6:18 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> Benjamin indicated that Peter probably has found the issue in the code
> (failure to properly reset on direction change) that might be causing
> this.

So honestly, once I looked at that hid_scroll_counter_handle_scroll()
function, that's the first thing I tried - get rid of the "half-way
threshold" thing, and reset on direction changes.

It fixes the instability, and I don't see the "back-and-forth"
movements and I don't get the "move the mouse and it generates mouse
wheel events" any more.

It basically makes the wheel _work_ for me.

I'm not entirely convinced it's as good as it used to be, though. It
still feels like it might be a bit over-sensitive, but that may be
because now I'm just looking for it..

Patch I'm using attached. I'm inclined to just commit it, but if
somebody has a better idea, I can test alternatives too.

                    Linus

--00000000000007413e05795f8e85
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jnug1vmy0>
X-Attachment-Id: f_jnug1vmy0

IGRyaXZlcnMvaGlkL2hpZC1pbnB1dC5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1pbnB1dC5jIGIvZHJpdmVy
cy9oaWQvaGlkLWlucHV0LmMKaW5kZXggNTY3YzNiZjY0NTE1Li5hMmY3NGU2YWRjNzAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaGlkL2hpZC1pbnB1dC5jCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1pbnB1
dC5jCkBAIC0xODU1LDMxICsxODU1LDMwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKGhpZGlucHV0X2Rp
c2Nvbm5lY3QpOwogdm9pZCBoaWRfc2Nyb2xsX2NvdW50ZXJfaGFuZGxlX3Njcm9sbChzdHJ1Y3Qg
aGlkX3Njcm9sbF9jb3VudGVyICpjb3VudGVyLAogCQkJCSAgICAgIGludCBoaV9yZXNfdmFsdWUp
CiB7Ci0JaW50IGxvd19yZXNfc2Nyb2xsX2Ftb3VudDsKLQkvKiBTb21lIHdoZWVscyB3aWxsIHJl
c3QgNy84dGhzIG9mIGEgbm90Y2ggZnJvbSB0aGUgcHJldmlvdXMgbm90Y2gKLQkgKiBhZnRlciBz
bG93IG1vdmVtZW50LCBzbyB3ZSB3YW50IHRoZSB0aHJlc2hvbGQgZm9yIGxvdy1yZXMgZXZlbnRz
IHRvCi0JICogYmUgaW4gdGhlIG1pZGRsZSBvZiB0aGUgbm90Y2hlcyAoZS5nLiBhZnRlciA0Lzh0
aHMpIGFzIG9wcG9zZWQgdG8gb24KLQkgKiB0aGUgbm90Y2hlcyB0aGVtc2VsdmVzICg4Lzh0aHMp
LgotCSAqLwotCWludCB0aHJlc2hvbGQgPSBjb3VudGVyLT5yZXNvbHV0aW9uX211bHRpcGxpZXIg
LyAyOworCWludCBsb3dfcmVzX3ZhbHVlLCByZW1haW5kZXIsIG11bHRpcGxpZXI7CiAKIAlpbnB1
dF9yZXBvcnRfcmVsKGNvdW50ZXItPmRldiwgUkVMX1dIRUVMX0hJX1JFUywKIAkJCSBoaV9yZXNf
dmFsdWUgKiBjb3VudGVyLT5taWNyb25zX3Blcl9oaV9yZXNfdW5pdCk7CiAKLQljb3VudGVyLT5y
ZW1haW5kZXIgKz0gaGlfcmVzX3ZhbHVlOwotCWlmIChhYnMoY291bnRlci0+cmVtYWluZGVyKSA+
PSB0aHJlc2hvbGQpIHsKLQkJLyogQWRkIChvciBzdWJ0cmFjdCkgMSBiZWNhdXNlIHdlIHdhbnQg
dG8gdHJpZ2dlciB3aGVuIHRoZSB3aGVlbAotCQkgKiBpcyBoYWxmLXdheSB0byB0aGUgbmV4dCBu
b3RjaCAoaS5lLiBzY3JvbGwgMSBub3RjaCBhZnRlciBhCi0JCSAqIDEvMiBub3RjaCBtb3ZlbWVu
dCwgMiBub3RjaGVzIGFmdGVyIGEgMSAxLzIgbm90Y2ggbW92ZW1lbnQsCi0JCSAqIGV0Yy4pLgot
CQkgKi8KLQkJbG93X3Jlc19zY3JvbGxfYW1vdW50ID0KLQkJCWNvdW50ZXItPnJlbWFpbmRlciAv
IGNvdW50ZXItPnJlc29sdXRpb25fbXVsdGlwbGllcgotCQkJKyAoaGlfcmVzX3ZhbHVlID4gMCA/
IDEgOiAtMSk7Ci0JCWlucHV0X3JlcG9ydF9yZWwoY291bnRlci0+ZGV2LCBSRUxfV0hFRUwsCi0J
CQkJIGxvd19yZXNfc2Nyb2xsX2Ftb3VudCk7Ci0JCWNvdW50ZXItPnJlbWFpbmRlciAtPQotCQkJ
bG93X3Jlc19zY3JvbGxfYW1vdW50ICogY291bnRlci0+cmVzb2x1dGlvbl9tdWx0aXBsaWVyOwot
CX0KKwkvKgorCSAqIFVwZGF0ZSB0aGUgbG93LXJlcyByZW1haW5kZXIgd2l0aCB0aGUgaGlnaC1y
ZXMgdmFsdWUsCisJICogYnV0IHJlc2V0IGlmIHRoZSBkaXJlY3Rpb24gaGFzIGNoYW5nZWQuCisJ
ICovCisJcmVtYWluZGVyID0gY291bnRlci0+cmVtYWluZGVyOworCWlmICgocmVtYWluZGVyIF4g
aGlfcmVzX3ZhbHVlKSA8IDApCisJCXJlbWFpbmRlciA9IDA7CisJcmVtYWluZGVyICs9IGhpX3Jl
c192YWx1ZTsKKworCS8qCisJICogVGhlbiBqdXN0IHVzZSB0aGUgcmVzb2x1dGlvbiBtdWx0aXBs
aWVyIHRvIHNlZSBpZgorCSAqIHdlIHNob3VsZCBzZW5kIGEgbG93LXJlcyAoYWthIHJlZ3VsYXIg
d2hlZWwpIGV2ZW50LgorCSAqLworCW11bHRpcGxpZXIgPSBjb3VudGVyLT5yZXNvbHV0aW9uX211
bHRpcGxpZXI7CisJbG93X3Jlc192YWx1ZSA9IHJlbWFpbmRlciAvIG11bHRpcGxpZXI7CisJcmVt
YWluZGVyIC09IGxvd19yZXNfdmFsdWUgKiBtdWx0aXBsaWVyOworCWNvdW50ZXItPnJlbWFpbmRl
ciA9IHJlbWFpbmRlcjsKKworCWlmIChsb3dfcmVzX3ZhbHVlKQorCQlpbnB1dF9yZXBvcnRfcmVs
KGNvdW50ZXItPmRldiwgUkVMX1dIRUVMLCBsb3dfcmVzX3ZhbHVlKTsKIH0KIEVYUE9SVF9TWU1C
T0xfR1BMKGhpZF9zY3JvbGxfY291bnRlcl9oYW5kbGVfc2Nyb2xsKTsK
--00000000000007413e05795f8e85--
