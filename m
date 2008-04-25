From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL Touchscreen
Date: Fri, 25 Apr 2008 15:52:32 -0700
Message-ID: <200804251552.32601.david-b@pacbell.net>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com> <20080425211041.GC28497@flint.arm.linux.org.uk> <1209159453.6990.48.camel@justin-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:23243 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752781AbYDYXHY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 19:07:24 -0400
In-Reply-To: <1209159453.6990.48.camel@justin-linux>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Justin Waters <justin.waters@timesys.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux@maxim.org.za" <linux@maxim.org.za>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Friday 25 April 2008, Justin Waters wrote:
>=20
> 	 =A0Since HRT
> support is not mainline for the SAM9 platforms,

It's not?  I though that all got merged.  PIT supports clocksource
and periodic clockevents, and the TC modules support oneshot timers
sufficient for HRT and NO_HZ.  Merged for 2.6.26-rc1 ...

- Dave


> I'm going to remove all=20
> references to it and worry about high resolution timer support at a
> later time.
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
