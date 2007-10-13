From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Sat, 13 Oct 2007 23:33:10 +0200
Message-ID: <1192311190.4828.97.camel@localhost>
References: <46F54D92.7000300@tng.de>
	 <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com>
	 <1190638998.12782.0.camel@localhost> <46F7BA08.6000201@tng.de>
	 <1190836596.1359.33.camel@localhost>
	 <d120d5000709261313j16f9612fx7d445b707df7784b@mail.gmail.com>
	 <1190915501.7636.4.camel@localhost>  <46FC1BC4.5050405@tng.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qDCm69XZUgPh5VumXIsH"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46FC1BC4.5050405@tng.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Thomas Rohwer <tr@tng.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org


--=-qDCm69XZUgPh5VumXIsH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-09-27 at 23:08 +0200, Thomas Rohwer wrote:
> >>> I think there is another bug in this. I mean whenever a mouse button is
> >>> pressed or the mouse is moved the counter should be reset - no?
> >>>
> >>> Currently the idle counter is just increased...
> >>>
> >>> I mean shouldn't it be
> >>>
> >>> if (x || y || key)
> >>>        dev->idlecount=0;
> >>>
> >>> if (!x && !y && !key)
> >>> {
> >>>        dev->idlecount++;
> >>>        if (dev->idlecount == 10) {
> >>>                dev->valid = 0;
> >>>                schedule_work(&dev->work);
> >>>        }
> >>> }
> 
> Hello,
> 
> I agree that this is makes sense. I was wondering if one can remove the whole
> idlecount logic. I tried replacing 10 with 1. This almost works; only if you press
> the touchpad button, after a reset happened, you first get a usb packet with the
> button state still 0 and after that one with button 1. I.e. with count 1 instead of 10
> you reset the device another time in this case. But one could handle this case separately.
> I am currently working with 2 instead of 10.

I am not sure whether it is worth fighting for. For the moment I think
we should just use the attached patch (where I as you suggest set
idlecount to 2).

So if there are no objections, Dmity please apply.

However if the touchpad sets some kind of 'ignore data' status bit on
'wakeup' this could be used to cleanup the code.

> I was also wondering when the procedure atp_reinit is executed after using schedule_work.
> Can it happen that atp_complete is called (even multiple times) before atp_reinit is executed?

I have no idea, Matthew?

Soeren.

--=-qDCm69XZUgPh5VumXIsH
Content-Disposition: attachment; filename=appletouch.patch
Content-Type: text/x-patch; name=appletouch.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogU29lcmVuIFNvbm5lbmJ1cmcgPGtlcm5lbEBubjcuZGU+DQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2lucHV0L21vdXNlL2FwcGxldG91Y2guYyBiL2RyaXZlcnMvaW5wdXQv
bW91c2UvYXBwbGV0b3VjaC5jDQppbmRleCBhMTgwNGJmLi5hYTJiYjRlIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pbnB1dC9tb3VzZS9hcHBsZXRvdWNoLmMNCisrKyBiL2RyaXZlcnMvaW5wdXQvbW91
c2UvYXBwbGV0b3VjaC5jDQpAQCAtMTI3LDcgKzEyNyw4IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUg
KHVzYiwgYXRwX3RhYmxlKTsNCiAgKiBUaHJlc2hvbGQgZm9yIHRoZSB0b3VjaHBhZCBzZW5zb3Jz
LiBBbnkgY2hhbmdlIGxlc3MgdGhhbiBBVFBfVEhSRVNIT0xEIGlzDQogICogaWdub3JlZC4NCiAg
Ki8NCi0jZGVmaW5lIEFUUF9USFJFU0hPTEQJIDUNCisjZGVmaW5lIEFUUF9USFJFU0hPTEQJNQ0K
KyNkZWZpbmUgQVRQX0lETEVfTElNSVQJMg0KIA0KIC8qIE1hY0Jvb2sgUHJvIChHZXlzZXIgMyAm
IDQpIGluaXRpYWxpemF0aW9uIGNvbnN0YW50cyAqLw0KICNkZWZpbmUgQVRQX0dFWVNFUjNfTU9E
RV9SRUFEX1JFUVVFU1RfSUQgMQ0KQEAgLTUwMiwxOCArNTAzLDIzIEBAIHN0YXRpYyB2b2lkIGF0
cF9jb21wbGV0ZShzdHJ1Y3QgdXJiKiB1cmIpDQogDQogCQkvKiByZXNldCB0aGUgYWNjdW11bGF0
b3Igb24gcmVsZWFzZSAqLw0KIAkJbWVtc2V0KGRldi0+eHlfYWNjLCAwLCBzaXplb2YoZGV2LT54
eV9hY2MpKTsNCisJfQ0KKw0KKwkvKiBHZXlzZXIgMyB3aWxsIGNvbnRpbnVlIHRvIHNlbmQgcGFj
a2V0cyBjb250aW51YWxseSBhZnRlcg0KKwkgICB0aGUgZmlyc3QgdG91Y2ggdW5sZXNzIHJlaW5p
dGlhbGlzZWQuIERvIHNvIGlmIGl0J3MgYmVlbg0KKwkgICBpZGxlIGZvciBhIHdoaWxlIGluIG9y
ZGVyIHRvIGF2b2lkIHdha2luZyB0aGUga2VybmVsIHVwDQorCSAgIHNldmVyYWwgaHVuZHJlZCB0
aW1lcyBhIHNlY29uZCAqLw0KIA0KLQkJLyogR2V5c2VyIDMgd2lsbCBjb250aW51ZSB0byBzZW5k
IHBhY2tldHMgY29udGludWFsbHkgYWZ0ZXINCi0JCSAgIHRoZSBmaXJzdCB0b3VjaCB1bmxlc3Mg
cmVpbml0aWFsaXNlZC4gRG8gc28gaWYgaXQncyBiZWVuDQotCQkgICBpZGxlIGZvciBhIHdoaWxl
IGluIG9yZGVyIHRvIGF2b2lkIHdha2luZyB0aGUga2VybmVsIHVwDQotCQkgICBzZXZlcmFsIGh1
bmRyZWQgdGltZXMgYSBzZWNvbmQgKi8NCi0JCWlmICgha2V5ICYmIGF0cF9pc19nZXlzZXJfMyhk
ZXYpKSB7DQorCWlmIChhdHBfaXNfZ2V5c2VyXzMoZGV2KSkgew0KKwkJaWYgKCF4ICYmICF5ICYm
ICFrZXkpIHsNCiAJCQlkZXYtPmlkbGVjb3VudCsrOw0KLQkJCWlmIChkZXYtPmlkbGVjb3VudCA9
PSAxMCkgew0KKwkJCWlmIChkZXYtPmlkbGVjb3VudCA9PSBBVFBfSURMRV9MSU1JVCkgew0KIAkJ
CQlkZXYtPnZhbGlkID0gMDsNCiAJCQkJc2NoZWR1bGVfd29yaygmZGV2LT53b3JrKTsNCiAJCQl9
DQogCQl9DQorCQllbHNlDQorCQkgICAgZGV2LT5pZGxlY291bnQ9MDsNCiAJfQ0KIA0KIAlpbnB1
dF9yZXBvcnRfa2V5KGRldi0+aW5wdXQsIEJUTl9MRUZULCBrZXkpOw0K


--=-qDCm69XZUgPh5VumXIsH--
