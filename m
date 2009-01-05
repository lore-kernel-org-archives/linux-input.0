From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: Add a detailed multi-touch finger data	report
  protocol (rev2)
Date: Mon, 05 Jan 2009 19:55:26 +0100
Message-ID: <4962579E.9080901@euromail.se>
References: <495804B1.10300@euromail.se> <20090105035758.GA28664@dingo.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:50557 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753399AbZAESzm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Jan 2009 13:55:42 -0500
In-Reply-To: <20090105035758.GA28664@dingo.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, jg@laptop.org, linux-kernel@vger.kernel.org

Peter Hutterer wrote:
[...]
> 
> To clarify: the MT_TOUCH_MAJOR is to track a touchpoint over time, and the
> BLOB_ID to compile a arbitrarily shaped touchpoint within the same event?

MT_TOUCH_MAJOR is the major size of the touching object, or "pressure" in
case the size of the approaching object (MT_WIDTH_MAJOR) is not available
to compare the size to. The touch and position packets are sent to the
multitouch X driver, where the actual finger tracking takes place. Thanks
for the chance to clarify this.


> Would it make sense to allow specification of a blob as bit/bytemask? There
> are a few devices that can do detection of multi-color non-rectangular
> touchpoints, especially camera-based systems. Limiting these to a sequence of
> rectangles means dropping information that may be useful for certain tasks
> (e.g. fingerprint detection).
> OTOH, a rectangle as bounding box with an accompanying (optional) bytemask can
> pass this data on to prospective clients.

Very interesting idea, although I believe it is beyond the scope of the
current patch.

