From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: elliminate multiple sensor support
 from rmi_f11.c
Date: Sun, 8 Dec 2013 16:10:39 -0800
Message-ID: <52A50A7F.9020506@synaptics.com>
References: <1386295167-866-1-git-send-email-aduggan@synaptics.com> <20131207160527.GB11635@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:45003 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab3LIAKn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Dec 2013 19:10:43 -0500
In-Reply-To: <20131207160527.GB11635@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 12/07/2013 08:05 AM, Dmitry Torokhov wrote:
> Hi Andrew,
> 
> On Thu, Dec 05, 2013 at 05:59:27PM -0800, Andrew Duggan wrote:
>> > This patch implements changes to the synaptics-rmi4 branch of
>> > Dmitry's input tree.  The base for the patch is commit
>> > 8ca01dc61a42b6f7bcba052a8c084000f7057a34.
>> > 
>> > This patch elliminates support for multiple sensors in rmi_f11. This feature
>> > has been removed from the RMI4 spec and no devices have every used multiple
>> > F11 sensors on a single device.
>> > 
>> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> I am a bit confused here - has this been coordinated with recent
> submission by Chris? I'd prefer if there was a single person from
> Synaptics posting patches at the same time, so that I know they are
> properly sequenced.

Hi,

To make things go faster, Andrew working with me to split the large
patch into manageable bites, and I asked him to go ahead and submit that
one.  That patch is in sequence - I'll sign off on it in a moment.
We'll run future patches through my email.

					Chris
