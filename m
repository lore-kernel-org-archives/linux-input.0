From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/4] isl29020: ambient light sensor
Date: Thu, 15 Apr 2010 11:15:51 +0100
Message-ID: <4BC6E757.3030204@cam.ac.uk>
References: <20100414124913.23181.75903.stgit@localhost.localdomain> <20100414125147.23181.5817.stgit@localhost.localdomain> <20100414224542.GX30807@buzzloop.caiaq.de> <20100414233554.3f020155@linux.intel.com> <20100415062023.GG30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:57344 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab0DOKNE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Apr 2010 06:13:04 -0400
In-Reply-To: <20100415062023.GG30801@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Alan Cox <alan@linux.intel.com>, linux-i2c@vger.kernel.org, khali@linux-fr.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/15/10 07:20, Daniel Mack wrote:
> On Wed, Apr 14, 2010 at 11:35:54PM +0100, Alan Cox wrote:
>>> Would it be possible to make the existing driver for the ISL29003
>>> support the ISL29020 as well?
>>
>> I dug the manuals out for these to take a look - the answer is they are
>> quite different chips. 
> 
> Hmm, sad :(
> 
> However, the driver should be applied to the ALS tree after all, unless
> Jonathan plans to drop the whole thing, which I doubt.
Sadly ALS is dead.  Linus made it pretty clear he wasn't going to pull it.

Hence currently either ALS drivers are going into misc (and can be moved
elsewhere later), or we are taking them into IIO (and hence staging)
where they fit fine and we can sort out a bridge to input to answer Linus'
issue with the original patch set.

In the thread following Alan's repost (having moved this driver to misc)
Greg just pointed out the sysfs interface needed documenting, and I've
suggested that we sort out the naming properly (in a way compliant with
hwmon and the new IIO abi.  90% of what the ALS subsystem contributed was
defining the ABI anyway!

Jonathan
