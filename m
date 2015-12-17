From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH RFC 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Thu, 17 Dec 2015 17:22:48 +0000
Message-ID: <5672EF68.3000800@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:43333 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbLQRWy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 12:22:54 -0500
In-Reply-To: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>

On 02/12/15 20:42, Nick Dyer wrote:
> This is a series of patches to add diagnostic data support to the Atmel
> maXTouch driver. There's an existing implementation in the open-source mxt-app
> tool, however there are performance advantages to moving this code into the driver.
> The algorithm for retrieving the data has been fairly consistent across a range of
> chips, with the exception of the mXT1386 series (see patch).
> 
> The intention is to open-source a utility which can read/display this data, this
> should be available very shortly.

Hi-

The utility to read this data has now been released, and you can find it at:
https://github.com/ndyer/heatmap

I've recorded a couple of videos of the utility in action on a Pixel 2:
* https://youtu.be/M0VD2gZt8Zk
* https://youtu.be/nwDLB4zikzU

regards

Nick
