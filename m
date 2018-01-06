From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Date: Sat, 6 Jan 2018 00:20:24 +0000
Message-ID: <20180106002024.012f44c0@alans-desktop>
References: <1515197240.26317.65.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:53528 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbeAFAUe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Jan 2018 19:20:34 -0500
In-Reply-To: <1515197240.26317.65.camel@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

> >From an IIO sensor point of view A Gesture sensor:  
> Outputs
> 	A pre defined activity type
> 		WAKE
> 		TILT
> 		GLANCE
> 		PICK_UP
> 		 &
> 		 more
> 
> 	A user defined activity type as "string"
> 
> Inputs
> 	A raw binary cdev interface to download templates/patterns
> 
> 
> I want to gather more opinions before submitting a RFC patch.

The only question I have is should it appear under IIO or should it be an
input event interface. It feels to me more like an input device in that in
this case while it's not keys or joystick it is still 'please do X'. That
might also make it much easier (in the non-Android space in particular)
to bind these activities to actions in things like web browsers.

(+ linux-input)

Alan
