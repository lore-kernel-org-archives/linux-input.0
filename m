From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Wed, 30 Sep 2015 08:41:57 +0200
Message-ID: <CA+icZUUV5cOpUqsx7PAvfi3hs9pa11=DXH=BEbjGnOJ+kDi_5Q@mail.gmail.com>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
	<CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11425ed6145b2a0520f13a56
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34619 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbbI3Gl6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 02:41:58 -0400
Received: by vkat63 with SMTP id t63so19427193vka.1
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2015 23:41:57 -0700 (PDT)
In-Reply-To: <CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

--001a11425ed6145b2a0520f13a56
Content-Type: text/plain; charset=UTF-8

> What shall I do... play with lockdep (print_irqtrace_events) in
> del_timer_sync()?

I recalled that when Jiri was thinking towards a "compiler bug" that
the part in del_timer_sync() emebedded in the "ifdef CONFIG_LOCKDEP"
is somehow "mis-compiled".
Furthermore, I see that try_to_del_timer_sync() is invoked within
del_timer_sync() which does a spin_unlock_irqrestore().

[ kernel/time/timer.c ]

int del_timer_sync(struct timer_list *timer)
{
#ifdef CONFIG_LOCKDEP
unsigned long flags;

/*
* If lockdep gives a backtrace here, please reference
* the synchronization rules above.
*/
local_irq_save(flags);
lock_map_acquire(&timer->lockdep_map);
lock_map_release(&timer->lockdep_map);
local_irq_restore(flags);
#endif
/*
* don't use it in hardirq context, because it
* could lead to deadlock.
*/
WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
for (;;) {
int ret = try_to_del_timer_sync(timer);
if (ret >= 0)
return ret;
cpu_relax();
}
}
EXPORT_SYMBOL(del_timer_sync);
#endif
...
int try_to_del_timer_sync(struct timer_list *timer)
{
struct tvec_base *base;
unsigned long flags;
int ret = -1;

debug_assert_init(timer);

base = lock_timer_base(timer, &flags);

if (base->running_timer != timer) {
timer_stats_timer_clear_start_info(timer);
ret = detach_if_pending(timer, base, true);
}
spin_unlock_irqrestore(&base->lock, flags);

return ret;
}
EXPORT_SYMBOL(try_to_del_timer_sync);
...

Is the attached patch suitable for a test?

I remember I tried to turn lockdep kernel-config for amd64 but that
was somehow tricky.

Shall I ask timer folks?

Thoughts?

Thanks!

- Sedat -

--001a11425ed6145b2a0520f13a56
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-timer-lockdep-Add-WARN_ON-irqs_disabled-to-del_timer.patch"
Content-Disposition: attachment;
	filename="0001-timer-lockdep-Add-WARN_ON-irqs_disabled-to-del_timer.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_if6fbzoa4

RnJvbSBlZGI0Y2I3MmM2MzFjNWU1ODhhZjQwNzk0ODMwYzViYjVkNmE5MjdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDMwIFNlcCAyMDE1IDA4OjIwOjE1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gdGlt
ZXI6IGxvY2tkZXA6IEFkZCBXQVJOX09OKGlycXNfZGlzYWJsZWQoKSkgdG8KIGRlbF90aW1lcl9z
eW5jKCkKCi0tLQoga2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jIHwgMSArCiBrZXJuZWwvdGltZS90
aW1lci5jICAgICAgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9rZXJuZWwvbG9ja2luZy9sb2NrZGVwLmMgYi9rZXJuZWwvbG9ja2luZy9sb2Nr
ZGVwLmMKaW5kZXggOGFjZmJmNzczZTA2Li44YjI5YjNkZDUxOGYgMTAwNjQ0Ci0tLSBhL2tlcm5l
bC9sb2NraW5nL2xvY2tkZXAuYworKysgYi9rZXJuZWwvbG9ja2luZy9sb2NrZGVwLmMKQEAgLTI0
MTAsNiArMjQxMCw3IEBAIHZvaWQgcHJpbnRfaXJxdHJhY2VfZXZlbnRzKHN0cnVjdCB0YXNrX3N0
cnVjdCAqY3VycikKIAlwcmludGsoInNvZnRpcnFzIGxhc3QgZGlzYWJsZWQgYXQgKCV1KTogIiwg
Y3Vyci0+c29mdGlycV9kaXNhYmxlX2V2ZW50KTsKIAlwcmludF9pcF9zeW0oY3Vyci0+c29mdGly
cV9kaXNhYmxlX2lwKTsKIH0KK0VYUE9SVF9TWU1CT0wocHJpbnRfaXJxdHJhY2VfZXZlbnRzKTsK
IAogc3RhdGljIGludCBIQVJESVJRX3ZlcmJvc2Uoc3RydWN0IGxvY2tfY2xhc3MgKmNsYXNzKQog
ewpkaWZmIC0tZ2l0IGEva2VybmVsL3RpbWUvdGltZXIuYyBiL2tlcm5lbC90aW1lL3RpbWVyLmMK
aW5kZXggODQxOTBmMDJiNTIxLi5mNDM0YjJkY2U2NDIgMTAwNjQ0Ci0tLSBhL2tlcm5lbC90aW1l
L3RpbWVyLmMKKysrIGIva2VybmVsL3RpbWUvdGltZXIuYwpAQCAtMTA4Miw2ICsxMDgyLDkgQEAg
aW50IGRlbF90aW1lcl9zeW5jKHN0cnVjdCB0aW1lcl9saXN0ICp0aW1lcikKICNpZmRlZiBDT05G
SUdfTE9DS0RFUAogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKKwlpZihXQVJOX09OKGlycXNfZGlz
YWJsZWQoKSkpCisJCXByaW50X2lycXRyYWNlX2V2ZW50cyhjdXJyZW50KTsKKwogCS8qCiAJICog
SWYgbG9ja2RlcCBnaXZlcyBhIGJhY2t0cmFjZSBoZXJlLCBwbGVhc2UgcmVmZXJlbmNlCiAJICog
dGhlIHN5bmNocm9uaXphdGlvbiBydWxlcyBhYm92ZS4KLS0gCjIuNS4zCgo=
--001a11425ed6145b2a0520f13a56--
