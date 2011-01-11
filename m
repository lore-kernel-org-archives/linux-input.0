From: Varun Wadekar <vwadekar@nvidia.com>
Subject: Re: NVidia Multitouch driver.
Date: Tue, 11 Jan 2011 11:12:05 +0530
Message-ID: <4D2BEDAD.5050604@nvidia.com>
References: <AANLkTi=KQMrFR7rO=4gY=GX-aHo+sckA8nGrE-1A9rpe@mail.gmail.com> <4D2BE29A.4060400@nvidia.com> <AANLkTike5xYAMCJKd7Lh0i4op3Z4fRDUMAOx5-s==541@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:14509 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab1AKFqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 00:46:13 -0500
In-Reply-To: <AANLkTike5xYAMCJKd7Lh0i4op3Z4fRDUMAOx5-s==541@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: USB list <linux-input@vger.kernel.org>, Harry Hong <hhong@nvidia.com>, Bharat Nihalani <bnihalani@nvidia.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Got it. I will try to get these changes pushed upstream.

Support for multiple fingers is completely touch panel driven. We have
successfully verified
than 10 fingers also work fine on Android with another touch panel.

On Tuesday 11 January 2011 11:00 AM, Mohamed Ikbel Boulabiar wrote:
> On Tue, Jan 11, 2011 at 5:54 AM, Varun Wadekar <vwadekar@nvidia.com> wrote:
>> Do you mean to say there are certain things missing in the touch driver?
>> What do you mean by the last linux kernel?
> I have found that patch by chance because I haven't seen it sent to
> linux-input ml (which what is the std)
> I just want it to get pushed to the mainline linux kernel as it is the
> upstream of all linux distributions and for the android linux kernel
> tree itself.
>
> I just don't like to see only android getting drivers patches as it
> can be seen as an action of forking the main kernel.
>
> You can rebase the patch to the last tree and get help and feedback
> from other developers for its integration. Company support of its own
> drivers is very appreciated here.
>
>
> And when analyzing the code I got a question. Does the nvodm hw
> supports only 2 fingers or it's only caused by android limitation ?
> Can the hw report more than 2 fingers ? (4 for example)
>
> Thanks
>
> i


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
