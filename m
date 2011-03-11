From: Richard Nauber <richard.nauber@googlemail.com>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Fri, 11 Mar 2011 10:23:27 +0100
Message-ID: <AANLkTi=Awco-yuQUr2ZFYHPGjfAFa2cLxN6aMby=M0VX@mail.gmail.com>
References: <20110308080414.GA2888@polaris.bitmath.org>
	<AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
	<20110308091434.GA3282@polaris.bitmath.org>
	<AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
	<20110308094630.GA3396@polaris.bitmath.org>
	<1299627518.2306.47.camel@itzy>
	<20110309082455.GA3166@polaris.bitmath.org>
	<AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
	<20110309092337.GC3824@polaris.bitmath.org>
	<AANLkTi=TJ3RPOSP3XyqOfX8Aeep3-uFcHmcia6+a2Wxy@mail.gmail.com>
	<20110309114038.GA9143@polaris.bitmath.org>
	<1299823326.1910.11.camel@itzy>
	<AANLkTims5Qg3m7pe-PBFNjmTmeOCPi6i8wqqrK1OJS84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39756 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1CKJX2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 04:23:28 -0500
Received: by qwd7 with SMTP id 7so1948629qwd.19
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2011 01:23:27 -0800 (PST)
In-Reply-To: <AANLkTims5Qg3m7pe-PBFNjmTmeOCPi6i8wqqrK1OJS84@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

>On Fri, Mar 11, 2011 at 7:53 AM, Benjamin Tissoires
><benjamin.tissoires@gmail.com> wrote:
> Hi Richard,
>
> I'm really sorry, but it's a NACK for me:
> what ever Henrik said, I do not want to have numerical constants
> throughout the code. It would be the open door to many others. The
> reason we have "mt_class" is to regroup each per-device parameters in
> it. So there is no need to introduce those constants everywhere.

Hm, so should I make a patch that applies on top of Henriks "Send
events per slot if CONTACTCOUNT is missing"  and uses the generic XY
fixup of my v3 patch?
