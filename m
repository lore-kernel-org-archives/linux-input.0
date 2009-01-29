From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/6] input: bcm5974: Prepare for a new trackpad header
 type
Date: Thu, 29 Jan 2009 23:30:37 +0100
Message-ID: <49822E0D.2070607@euromail.se>
References: <1233138229-12489-1-git-send-email-rydberg@euromail.se>	<1233138229-12489-2-git-send-email-rydberg@euromail.se> <20090129003321.e9c8c36c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759993AbZA2WbV@vger.kernel.org>
In-Reply-To: <20090129003321.e9c8c36c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Andrew Morton wrote:
> On Wed, 28 Jan 2009 11:23:44 +0100 "Henrik Rydberg" <rydberg@euromail.se> wrote:

Thanks for taking care of the patches, and for spotting the surplus
patches 5/6 and 6/6 - my mistake.

>> +	f = (const struct tp_finger *)(dev->tp_data + c->tp_offset);
> 
> Is there anything which guarantees that `f' is sufficiently aligned? 
> If not, the code might cause unaligned exceptions on some
> architectures?
> 

I believe it is - I will send a patch in reply to this message that
ought to make it clearer.

Thanks,
Henrik
