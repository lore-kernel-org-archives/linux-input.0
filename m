From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Wed, 21 Sep 2011 13:42:55 +0200
Message-ID: <20110921114255.GA31611@polaris.bitmath.org>
References: <20110913080911.GA4986@polaris.bitmath.org>
 <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
 <20110914071524.GA3422@polaris.bitmath.org>
 <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com>
 <20110916105036.GA4455@polaris.bitmath.org>
 <CANRwn3TstEAhgt5=Sxu6KMOyu3rtC9CCeQWU7Qa5-jRXUfgBdw@mail.gmail.com>
 <20110917112114.GA3015@polaris.bitmath.org>
 <4E77D2FE.8060709@gmail.com>
 <CAMu+ixh_Am6vNn6oz4NEiaZ6+4UYXp=smu7BCekYze7S_L0hng@mail.gmail.com>
 <4E77FF32.5050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:37902 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab1IULil (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Sep 2011 07:38:41 -0400
Received: from iph5.telenor.se (iph5.telenor.se [195.54.127.136])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 07480EAC70
	for <linux-input@vger.kernel.org>; Wed, 21 Sep 2011 13:38:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E77FF32.5050806@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Jeffrey Brown <jeffbrown@android.com>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

> To condense all of the above, we can generalize the rules to:
> 
> * INPUT_PROP_DIRECT only has meaning for BTN_TOOL_FINGER etc.
> * INPUT_PROP_POINTER only has meaning for BTN_TOOL_PEN / BTN_TOOL_BRUSH etc.
> 
> > We should also define heuristics for legacy devices that don't set
> > either INPUT_PROP_DIRECT or INPUT_PROP_POINTER.
> 
> The above generalization should take care of this.

Yes, I believe this will work nicely.

Thanks,
Henrik
