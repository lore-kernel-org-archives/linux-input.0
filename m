From: Daniel Manrique <daniel.manrique@canonical.com>
Subject: Re: Bug: touchpad unresponsive after resume from S3 (psmouse driver)
Date: Fri, 02 Dec 2011 12:39:33 -0500
Message-ID: <4ED90D55.20802@canonical.com>
References: <4ED507AB.6040905@canonical.com> <20111129175333.GE4241@core.coreip.homeip.net> <4ED535E7.5030108@canonical.com> <20111130001748.GA2270@core.coreip.homeip.net> <4ED64932.90407@canonical.com> <20111201051534.GB16816@core.coreip.homeip.net> <4ED7E60F.7020306@canonical.com> <20111202061623.GA9688@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54876 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189Ab1LBRjh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2011 12:39:37 -0500
In-Reply-To: <20111202061623.GA9688@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 11-12-02 01:16 AM, Dmitry Torokhov wrote:
> On Thu, Dec 01, 2011 at 03:39:43PM -0500, Daniel Manrique wrote:
>>
>> The ssleep(1); line is what appears to do the trick; the version that just
>> queries the ID exhibits the same problem I reported initially, while the one
>> that just ssleeps works fine, with the touchpad working OK after resuming.
>>
>> I'll await further instructions on this, thanks so much for your help!
>>
> 
> OK, great. Could you please try the patch below to make sure it works as
> intended and I'll queue it to upstream/stable?
> 
> Thanks.
> 

Hi Dmitry!

I tried the attached patch and tested just as before, I created two versions of
the module, one with the patch, one without, and tested them.

Yes, the code in the patch works as it did before, and the touchpad works fine
after resuming. I tried several times with both modules to be sure, and results
are consistent every time (i.e. patched module works, unpatched one always fails)

Thanks for this!

- Daniel
