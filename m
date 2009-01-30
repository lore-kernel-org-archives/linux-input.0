From: Joon Young Shim <dofmind@gmail.com>
Subject: Re: [PATCH 6/6] input: Add a detailed multi-touch finger data report
	protocol (rev2)
Date: Fri, 30 Jan 2009 15:10:55 +0900
Message-ID: <4e1455be0901292210t793c942cg5776079ecc99080e@mail.gmail.com>
References: <1233138229-12489-1-git-send-email-rydberg@euromail.se>
	 <1233138229-12489-2-git-send-email-rydberg@euromail.se>
	 <1233138229-12489-3-git-send-email-rydberg@euromail.se>
	 <1233138229-12489-4-git-send-email-rydberg@euromail.se>
	 <1233138229-12489-5-git-send-email-rydberg@euromail.se>
	 <1233138229-12489-6-git-send-email-rydberg@euromail.se>
	 <1233138229-12489-7-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:15802 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZA3GK4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 01:10:56 -0500
In-Reply-To: <1233138229-12489-7-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

2009/1/28 Henrik Rydberg <rydberg@euromail.se>:
> In order to utilize the full power of the new multi-touch devices, a
> way to report detailed finger data to user space is needed. This patch
> adds a multi-touch (MT) protocol which allows drivers to report details
> for an arbitrary number of fingers.
>
> The driver sends a SYN_MT_REPORT event via the input_mt_sync() function
> when a complete finger has been reported.
>
> In order to stay compatible with existing applications, the data
> reported in a finger packet must not be recognized as single-touch
> events. In addition, all finger data must bypass input filtering,
> since subsequent events of the same type refer to different fingers.
>
> A set of ABS_MT events with the desired properties are defined. The
> events are divided into categories, to allow for partial implementation.
> The minimum set consists of ABS_MT_TOUCH_MAJOR, ABS_MT_POSITION_X and
> ABS_MT_POSITION_Y, which allows for multiple fingers to be tracked.
> If the device supports it, the ABS_MT_WIDTH_MAJOR may be used to provide
> the size of the approaching finger. Anisotropy and direction may be
> specified with ABS_MT_TOUCH_MINOR, ABS_MT_WIDTH_MINOR and
> ABS_MT_ORIENTATION. Devices with more granular information may specify
> general shapes as blobs, i.e., as a sequence of rectangular shapes
> grouped together by a ABS_MT_BLOB_ID. Finally, the ABS_MT_TOOL_TYPE
> may be used to specify whether the touching tool is a finger or a pen.
>

Hi Henrik,

Sorry for multiple posts.

I want to know how calculates touch coordinates at user space using a
set of ABS_MT.
If i do dual touch, can i get correct two coordinates through ABS_MT report?


Joonyoung
