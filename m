From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Thu, 27 Sep 2007 17:51:41 +0000
Message-ID: <1190915501.7636.4.camel@localhost>
References: <46F54D92.7000300@tng.de>
	 <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com>
	 <1190638998.12782.0.camel@localhost> <46F7BA08.6000201@tng.de>
	 <1190836596.1359.33.camel@localhost>
	 <d120d5000709261313j16f9612fx7d445b707df7784b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VXreve+Q+ypb7vDfGyEQ"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000709261313j16f9612fx7d445b707df7784b@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Rohwer <tr@tng.de>, linux-input@atrey.karlin.mff.cuni.cz, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org


--=-VXreve+Q+ypb7vDfGyEQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-09-26 at 16:13 -0400, Dmitry Torokhov wrote:
> On 9/26/07, Soeren Sonnenburg <kernel@nn7.de> wrote:
> >
> > On Mon, 2007-09-24 at 15:22 +0200, Thomas Rohwer wrote:
> > > Hello,
> > >
> > > > could you please re-send the patch? I for some reason have yet to see
> > > > it ...
> > >
> > > here it is again, adressing also the comments from Dmitry.
> >
> > Thomas, Matthew and Dmitry,
> >
> > I think there is another bug in this. I mean whenever a mouse button is
> > pressed or the mouse is moved the counter should be reset - no?
> >
> > Currently the idle counter is just increased...
> >
> > I mean shouldn't it be
> >
> > if (x || y || key)
> >        dev->idlecount=0;
> >
> > if (!x && !y && !key)
> > {
> >        dev->idlecount++;
> >        if (dev->idlecount == 10) {
> >                dev->valid = 0;
> >                schedule_work(&dev->work);
> >        }
> > }
> >
> 
> Yes, I think you are right. I guess one could trigger an extra reset
> by pressing the button repeatedly witout touching the pad. But because
> we won't do reset while the button is pressed we'll never lose release
> event.
> 
> I guess we want to fix it but it can wait for 2.6.24. A patch woudl be
> appreciated.

Patch is attached. As all these if () conditions made it quite
unreadable I moved the block dealing with geyser 3 and above to the very
bottom. Still compiles/works for me. Please have a look.

Soeren

--=-VXreve+Q+ypb7vDfGyEQ
Content-Disposition: attachment; filename=appletouch.diff
Content-Type: text/x-patch; name=appletouch.diff; charset=ISO-8859-15
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogU29lcmVuIFNvbm5lbmJ1cmcgPGtlcm5lbEBubjcuZGU+DQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2lucHV0L21vdXNlL2FwcGxldG91Y2guYyBiL2RyaXZlcnMvaW5wdXQv
bW91c2UvYXBwbGV0b3VjaC5jDQppbmRleCBhMTgwNGJmLi43OGYzMGIyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pbnB1dC9tb3VzZS9hcHBsZXRvdWNoLmMNCisrKyBiL2RyaXZlcnMvaW5wdXQvbW91
c2UvYXBwbGV0b3VjaC5jDQpAQCAtNTAyLDE4ICs1MDIsMjMgQEAgc3RhdGljIHZvaWQgYXRwX2Nv
bXBsZXRlKHN0cnVjdCB1cmIqIHVyYikNCiANCiAJCS8qIHJlc2V0IHRoZSBhY2N1bXVsYXRvciBv
biByZWxlYXNlICovDQogCQltZW1zZXQoZGV2LT54eV9hY2MsIDAsIHNpemVvZihkZXYtPnh5X2Fj
YykpOw0KKwl9DQorDQorCS8qIEdleXNlciAzIHdpbGwgY29udGludWUgdG8gc2VuZCBwYWNrZXRz
IGNvbnRpbnVhbGx5IGFmdGVyDQorCSAgIHRoZSBmaXJzdCB0b3VjaCB1bmxlc3MgcmVpbml0aWFs
aXNlZC4gRG8gc28gaWYgaXQncyBiZWVuDQorCSAgIGlkbGUgZm9yIGEgd2hpbGUgaW4gb3JkZXIg
dG8gYXZvaWQgd2FraW5nIHRoZSBrZXJuZWwgdXANCisJICAgc2V2ZXJhbCBodW5kcmVkIHRpbWVz
IGEgc2Vjb25kICovDQogDQotCQkvKiBHZXlzZXIgMyB3aWxsIGNvbnRpbnVlIHRvIHNlbmQgcGFj
a2V0cyBjb250aW51YWxseSBhZnRlcg0KLQkJICAgdGhlIGZpcnN0IHRvdWNoIHVubGVzcyByZWlu
aXRpYWxpc2VkLiBEbyBzbyBpZiBpdCdzIGJlZW4NCi0JCSAgIGlkbGUgZm9yIGEgd2hpbGUgaW4g
b3JkZXIgdG8gYXZvaWQgd2FraW5nIHRoZSBrZXJuZWwgdXANCi0JCSAgIHNldmVyYWwgaHVuZHJl
ZCB0aW1lcyBhIHNlY29uZCAqLw0KLQkJaWYgKCFrZXkgJiYgYXRwX2lzX2dleXNlcl8zKGRldikp
IHsNCisJaWYgKGF0cF9pc19nZXlzZXJfMyhkZXYpKSB7DQorCQlpZiAoIXggJiYgIXkgJiYgIWtl
eSkgew0KIAkJCWRldi0+aWRsZWNvdW50Kys7DQogCQkJaWYgKGRldi0+aWRsZWNvdW50ID09IDEw
KSB7DQogCQkJCWRldi0+dmFsaWQgPSAwOw0KIAkJCQlzY2hlZHVsZV93b3JrKCZkZXYtPndvcmsp
Ow0KIAkJCX0NCiAJCX0NCisJCWVsc2UNCisJCQlkZXYtPmlkbGVjb3VudD0wOw0KIAl9DQogDQog
CWlucHV0X3JlcG9ydF9rZXkoZGV2LT5pbnB1dCwgQlROX0xFRlQsIGtleSk7DQo=


--=-VXreve+Q+ypb7vDfGyEQ--
