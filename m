From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [patch 2.6.29-rc2] input:  dm355evm_keys driver
Date: Tue, 23 Jun 2009 07:59:53 -0700
Message-ID: <87my7zov12.fsf@deeprootsystems.com>
References: <200901171315.08019.david-b@pacbell.net>
	<200906211710.50537.david-b@pacbell.net>
	<20090623050519.GA14724@dtor-d630.eng.vmware.com>
	<200906222240.01093.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:24324 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760680AbZFWPFy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 11:05:54 -0400
Received: by wf-out-1314.google.com with SMTP id 26so36300wfd.4
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2009 08:05:56 -0700 (PDT)
In-Reply-To: <200906222240.01093.david-b@pacbell.net> (David Brownell's message of "Mon\, 22 Jun 2009 22\:40\:00 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> On Monday 22 June 2009, Dmitry Torokhov wrote:
>>=20
>> > Appended is a minor tweak to this code. =A0I'm going to resend
>> > the patch again. =A0Maybe one day, soon, I can take it out of
>> > my list of patches-due-to-hit-mainline ...
>>=20
>> As you have noticed the driver is in mainline already;
>
> Actually I didn't notice until just now.  It was moved
> from input/keyboard to input/misc.  And I wasn't cc'd
> on this at any point ... so it's no wonder I had no idea
> what was happening!
>
> OK, so thanks for merging.  Kevin, this means you can
> remove the original code ... and will want to update
> the defconfig to use the new symbol.

OK, done.   I just reverted all previous commits and cherry-picked
the upstream one until I merge with upstream.

Pushed to davinci git.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
