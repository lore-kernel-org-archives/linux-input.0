From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [patch]GPIO button is supposed to wake the system up if the wakeup
 attribute is set
Date: Mon, 14 Apr 2014 23:42:21 +0800
Message-ID: <534C01DD.4010807@linux.intel.com>
References: <5345FDBD.9090908@linux.intel.com> <20140410114810.73e1d4b6@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47391 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbaDNPmb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 11:42:31 -0400
In-Reply-To: <20140410114810.73e1d4b6@alan.etchedpixels.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, linux-input@vger.kernel.org

ping...

On 2014/4/10 18:48, One Thousand Gnomes wrote:
> On Thu, 10 Apr 2014 10:11:09 +0800
> "Li, Aubrey" <aubrey.li@linux.intel.com> wrote:
> 
>> When the wakeup attribute is set, GPIO button is supposed to set
>> irqflag - IRQF_NO_SUSPEND to request irq. So when the system enters
>> the suspend sleep mode, the GPIO irq keeps enabled and is able to
>> wake the system up.
>>
>> The affected/tested machines include Dell Venue 11 Pro and Asus T100TA.
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> 
> Tested-by: Alan Cox <alan@linux.intel.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

