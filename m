From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to choeck for a gpio-keys based switch state?
Date: Fri, 15 May 2009 11:58:06 -0700
Message-ID: <20090515185806.GA22662@dtor-d630.eng.vmware.com>
References: <4A0D8EAB.6070900@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:42407 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZEOS6W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 14:58:22 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1151778rvb.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2009 11:58:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A0D8EAB.6070900@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: postmaster@icnet.pl
Cc: linux-input@vger.kernel.org

Hi Janusz,

On Fri, May 15, 2009 at 05:47:55PM +0200, Janusz Krzysztofik wrote:
> Hi,
>
> Greetings from new list member.
>
> I am trying to create a gpio-keys based platform device driver for a  
> hook switch. I am wondering if there is a possibility to check for the  
> switch state before the first event comes up. I think this feature could  
> be essential for correct user experience - an application should know  
> the switch state from the start.
> As I am not able to find such functionality in the current gpio-keys  
> driver, I wonder if this could be done over gpiolib sysfs interface by  
> adding optional gpio_export() call to the driver init function. I can  
> try to provide a patch if this sounds reasonable to you.
>

Your application should use EVIOCGSW ioctl to query the initial state of
the switches.

-- 
Dmitry
