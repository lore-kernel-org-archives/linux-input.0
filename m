From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Added device to hid-ff
Date: Fri, 16 Feb 2007 12:28:44 -0500
Message-ID: <d120d5000702160928t23741e18jf3dc0fd95c3ab4cd@mail.gmail.com>
References: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com>
	 <op.tns2alf2a64tfs@localhost>
	 <d120d5000702151142l5dca88f7nc71f58473fa27040@mail.gmail.com>
	 <45D4B9AB.70509@gmail.com>
	 <38b3b7c0702160743g67ae3e55pbccad84eefc2368b@mail.gmail.com>
	 <d120d5000702160803g54616f28ya1d13fb4bb78503b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6316_5549806.1171646924944"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000702160803g54616f28ya1d13fb4bb78503b@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, "STenyaK (Bruno Gonzalez)" <stenyak@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Valentin Zagura <puthre@gmail.com>
List-Id: linux-input@vger.kernel.org

------=_Part_6316_5549806.1171646924944
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2/16/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 2/16/07, johann deneux <johann.deneux@gmail.com> wrote:
> > On 2/15/07, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> > > Dmitry Torokhov wrote:
> > > > On 2/15/07, STenyaK (Bruno Gonzalez) <stenyak@gmail.com> wrote:
> > > >> Sorry for not providing a proper patch, could you please also add
> > > >>         {0x46d, 0xc294, hid_lgff_init}, // Logitech G25 wheel
> > > >> to the list? I tested it here and that wheel is also working.
> > > >>
> > > >
> > > > OK.
> > > >
> > >
> > > Hmm.. Shouldn't an entry also be added to the devices[] list in
> > > hid-lgff.c for these devices? (and it seems one device is already
> > > missing from there in the current kernel).
> > >
> > > I'm not able to check right now, but I think some earlier kernels may
> > > have defaulted to ff_joystick if no entry is present in devices[], hence
> > > these devices working for some without the entry.
> > > (so the alternative is to restore that behaviour)
> >
> > Yes, defaulting to joystick was the way it was when I wrote hid-lgff.c, and
> > I guess Valentin made his original patch on a kernel where defaulting was
> > still there.
> > I'll send a separate mail with the patch adding the devices there too, but I
> > personally think defaulting was nice. Was there a reason behind the removal?
> >
>
> Simple oversight. I think we should restore defaulting.
>

Something like the attached should do I think...

-- 
Dmitry

------=_Part_6316_5549806.1171646924944
Content-Type: text/plain; name=hid-lgff-default-to-joystick.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ey8wayne
Content-Disposition: attachment; filename="hid-lgff-default-to-joystick.patch"

SW5wdXQ6IGhpZC1sZ2ZmIC0gdHJlYXQgZGV2aWNlcyBhcyBqb3lzdGlja3MgdW5sZXNzIHRvbGQg
b3RoZXJ3aXNlCgpCeSBkZWZhdWx0IHRocmVhdCBkZXZpY2VzIGFzIGpveXN0aWNrcyB3aXRoIGNv
bnN0YW50IGZvcmNlLWZlZWRiYWNrCmVmZmVjdC4KClNpZ25lZC1vZmYtYnk6IERtaXRyeSBUb3Jv
a2hvdiA8ZHRvckBtYWlsLnJ1PgotLS0KIGRyaXZlcnMvdXNiL2lucHV0L2hpZC1sZ2ZmLmMgfCAg
IDEwICsrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpJbmRleDogbGludXgvZHJpdmVycy91c2IvaW5wdXQvaGlkLWxnZmYuYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsaW51eC5vcmlnL2RyaXZlcnMvdXNiL2lucHV0L2hpZC1sZ2ZmLmMKKysrIGxpbnV4
L2RyaXZlcnMvdXNiL2lucHV0L2hpZC1sZ2ZmLmMKQEAgLTU1LDcgKzU1LDYgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBkZXZfdHlwZSBkZXZpY2VzW10gPQogCXsgMHgwNDZkLCAweGMyOTQsIGZmX2pv
eXN0aWNrIH0sCiAJeyAweDA0NmQsIDB4YzI5NSwgZmZfam95c3RpY2sgfSwKIAl7IDB4MDQ2ZCwg
MHhjYTAzLCBmZl9qb3lzdGljayB9LAotCXsgMHgwMDAwLCAweDAwMDAsIGZmX2pveXN0aWNrIH0K
IH07CiAKIHN0YXRpYyBpbnQgaGlkX2xnZmZfcGxheShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYsIHZv
aWQgKmRhdGEsIHN0cnVjdCBmZl9lZmZlY3QgKmVmZmVjdCkKQEAgLTEwNyw4ICsxMDYsOSBAQCBp
bnQgaGlkX2xnZmZfaW5pdChzdHJ1Y3QgaGlkX2RldmljZSogaGlkCiAJc3RydWN0IGlucHV0X2Rl
diAqZGV2ID0gaGlkaW5wdXQtPmlucHV0OwogCXN0cnVjdCBoaWRfcmVwb3J0ICpyZXBvcnQ7CiAJ
c3RydWN0IGhpZF9maWVsZCAqZmllbGQ7CisJY29uc3Qgc2lnbmVkIHNob3J0ICpmZl9iaXRzID0g
ZmZfam95c3RpY2s7CiAJaW50IGVycm9yOwotCWludCBpLCBqOworCWludCBpOwogCiAJLyogRmlu
ZCB0aGUgcmVwb3J0IHRvIHVzZSAqLwogCWlmIChsaXN0X2VtcHR5KHJlcG9ydF9saXN0KSkgewpA
QCAtMTMyLDEyICsxMzIsMTQgQEAgaW50IGhpZF9sZ2ZmX2luaXQoc3RydWN0IGhpZF9kZXZpY2Uq
IGhpZAogCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGRldmljZXMpOyBpKyspIHsKIAkJaWYg
KGRldi0+aWQudmVuZG9yID09IGRldmljZXNbaV0uaWRWZW5kb3IgJiYKIAkJICAgIGRldi0+aWQu
cHJvZHVjdCA9PSBkZXZpY2VzW2ldLmlkUHJvZHVjdCkgewotCQkJZm9yIChqID0gMDsgZGV2aWNl
c1tpXS5mZltqXSA+PSAwOyBqKyspCi0JCQkJc2V0X2JpdChkZXZpY2VzW2ldLmZmW2pdLCBkZXYt
PmZmYml0KTsKKwkJCWZmX2JpdHMgPSBkZXZpY2VzW2ldLmZmOwogCQkJYnJlYWs7CiAJCX0KIAl9
CiAKKwlmb3IgKGkgPSAwOyBmZl9iaXRzW2ldID49IDA7IGkrKykKKwkJc2V0X2JpdChmZl9iaXRz
W2ldLCBkZXYtPmZmYml0KTsKKwogCWVycm9yID0gaW5wdXRfZmZfY3JlYXRlX21lbWxlc3MoZGV2
LCBOVUxMLCBoaWRfbGdmZl9wbGF5KTsKIAlpZiAoZXJyb3IpCiAJCXJldHVybiBlcnJvcjsK
------=_Part_6316_5549806.1171646924944--
