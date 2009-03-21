From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: question on device registration
Date: Sat, 21 Mar 2009 10:42:24 -0700
Message-ID: <200903211042.26685.dmitry.torokhov@gmail.com>
References: <200807022208.57032.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:48600 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405AbZCWPHO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2009 11:07:14 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2126132yxl.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2009 08:07:12 -0700 (PDT)
In-Reply-To: <200807022208.57032.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org

On Wednesday 02 July 2008 13:08:56 Oliver Neukum wrote:
> Hi,
>
> what happens if you call input_report_key(), input_report_rel() or
> input_sync() for a device before you call input_register_device() ?
>

Well, this surely be a blast from the past for you but I was going
through my old mail...

You can safely use input_report* on an unrefistered input device as
long as it was alloocated with input_allocate_device(). The reported
events will simply be dropped by the input core.

-- 
Dmitry
