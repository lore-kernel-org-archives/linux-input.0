From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Fri, 11 Mar 2011 10:52:55 +0100
Message-ID: <AANLkTimQWT9BtLHVL8HgaiS8tabrtUYGK-Z3qjH73QvH@mail.gmail.com>
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
	<AANLkTi=Awco-yuQUr2ZFYHPGjfAFa2cLxN6aMby=M0VX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33872 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab1CKJw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 04:52:56 -0500
Received: by wwa36 with SMTP id 36so2994459wwa.1
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2011 01:52:55 -0800 (PST)
In-Reply-To: <AANLkTi=Awco-yuQUr2ZFYHPGjfAFa2cLxN6aMby=M0VX@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi Richard,

On Fri, Mar 11, 2011 at 10:23, Richard Nauber
<richard.nauber@googlemail.com> wrote:
>>On Fri, Mar 11, 2011 at 7:53 AM, Benjamin Tissoires
>><benjamin.tissoires@gmail.com> wrote:
>> Hi Richard,
>>
>> I'm really sorry, but it's a NACK for me:
>> what ever Henrik said, I do not want to have numerical constants
>> throughout the code. It would be the open door to many others. The
>> reason we have "mt_class" is to regroup each per-device parameters i=
n
>> it. So there is no need to introduce those constants everywhere.
>
> Hm, so should I make a patch that applies on top of Henriks "Send
> events per slot if CONTACTCOUNT is missing" =A0and uses the generic X=
Y
> fixup of my v3 patch?
>

I would say so. Please just change the name of the field .axis by a bet=
ter name.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
