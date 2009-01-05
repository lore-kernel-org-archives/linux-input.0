From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] input: Add a detailed multi-touch finger data
	report  protocol (rev2)
Date: Mon, 5 Jan 2009 13:57:59 +1000
Message-ID: <20090105035758.GA28664@dingo.redhat.com>
References: <495804B1.10300@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:42008 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752227AbZAED7A (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Jan 2009 22:59:00 -0500
Content-Disposition: inline
In-Reply-To: <495804B1.10300@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, jg@laptop.org, linux-kernel@vger.kernel.org

On Sun, Dec 28, 2008 at 11:58:57PM +0100, Henrik Rydberg wrote:
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
> grouped together by a ABS_MT_BLOB_ID. 

To clarify: the MT_TOUCH_MAJOR is to track a touchpoint over time, and the
BLOB_ID to compile a arbitrarily shaped touchpoint within the same event?

Would it make sense to allow specification of a blob as bit/bytemask? There
are a few devices that can do detection of multi-color non-rectangular
touchpoints, especially camera-based systems. Limiting these to a sequence of
rectangles means dropping information that may be useful for certain tasks
(e.g. fingerprint detection).
OTOH, a rectangle as bounding box with an accompanying (optional) bytemask can
pass this data on to prospective clients.

Cheers,
  Peter
