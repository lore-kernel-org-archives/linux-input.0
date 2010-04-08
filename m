From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH] input: mt: introduce MT event slots
Date: Wed, 07 Apr 2010 23:07:09 -0400
Message-ID: <87tyrmiqw2.fsf@troilus.org>
References: <1270685590-2204-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:42849 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753145Ab0DHDHP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Apr 2010 23:07:15 -0400
In-Reply-To: <1270685590-2204-1-git-send-email-rydberg@euromail.se> (Henrik
	Rydberg's message of "Thu, 8 Apr 2010 02:13:10 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Henrik Rydberg writes:

> With the rapidly increasing number of intelligent multi-contact and
> multi-user devices, the need to send digested, filtered information
> from a set of different sources within the same device is imminent.
> This patch adds the concept of slots to the MT protocol. The slots
> enumerate a set of identified sources, such that all MT events
> can be passed independently and selectively per identified source.
>
> The protocol works like this: Instead of sending a SYN_MT_REPORT
> event immediately after the contact data, one sends a SYN_MT_SLOT
> event immediately before the contact data. The input core will only
> emit events for the slots corresponding to the contacts that have
> changed. It is assumed that the same slot is used for the duration
> of an initiated contact.

How would the slot number for a contact be chosen?  If the kernel makes
that assignment, what should a "slot" correspond to from a computer
user's perspective?  "Set[s] of identified sources" is a little vague:
Does it mean contacts from one hand, contacts in one displayed window
(assuming the touch surface is a screen), or something else?  (I assume
it would not duplicate the blob or tracking IDs already defined for MT
events.)  It seems like those would be important aspects of the protocol
to document in Documentation/input/multi-touch-protocol.txt --
otherwise, driver implementers or application developers might get it
wrong.

Michael Poole
