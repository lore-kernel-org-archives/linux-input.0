From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Tue, 11 Nov 2008 19:05:45 +0100
Message-ID: <4919C979.3000501@euromail.se>
References: <49109C91.6090207@euromail.se> <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754824AbYKKSGG@vger.kernel.org>
In-Reply-To: <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Tue, 4 Nov 2008, Henrik Rydberg wrote:
> 
>> The unibody MacBook 5 and MacBook Pro 5 come with a new version of
>> the bcm5974 trackpad. This patch adds the USB device ids and all
>> the appropriate quirks, including hid_blacklist.
>>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> 
> Applied, thanks Henrik (and sorry for the delay, I have been offline for a 
> few days).
> 

No worries. I should have mentioned earlier that the hid update
is best synchronized with the bcm5974 update, since the latter
is the only driver that will pick the mouse interface up after
the hid update. The bcm5974 patch was sent on October 23, but
I have not received any feedback to it yet.

Cheers,
Henrik
