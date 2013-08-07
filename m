From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c-hid: remove mostly useless parameter 'debug'
Date: Wed, 07 Aug 2013 18:21:36 +0300
Message-ID: <1375888896.403.23.camel@smile>
References: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>
	  <1375441636-12921-2-git-send-email-andriy.shevchenko@linux.intel.com>
	  <CAN+gG=Ec=jJy7HxRW08up+=Z8C0Lz4B8bhPcP+7__zuONnCAgw@mail.gmail.com>
	 <1375454987.31118.77.camel@smile> <51FBF71E.1040802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22173 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab3HGPWB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Aug 2013 11:22:01 -0400
In-Reply-To: <51FBF71E.1040802@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, 2013-08-02 at 20:14 +0200, Benjamin Tissoires wrote: 
> On 02/08/13 16:49, Andy Shevchenko wrote:

> > Usually when I see such code I understood it was written in
> > pre-dynamic-debug epoch. So, my point is to switch to dynamic debug and
> > use it efficiently.
> 
> Ok, so if you can guarantee me that adding the proper kernel parameter
> will allow me to retrieve all the i2c-hid logs from the boot, then I'd
> be happy to ack this. However, I have no way to test this right now, so
> I'll need to trust you (that's why I'm asking you to do proper testing).

Just to your information, I noticed that Greg KH did something like I
propose for usb drivers (misc, serial, ...).

So, it would be considered as third party opinion, I guess.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
