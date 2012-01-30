From: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Subject: Re: [PATCH] Input: Document the device properties
Date: Mon, 30 Jan 2012 14:23:40 +0200
Message-ID: <4F268BCC.4000008@canonical.com>
References: <1327912546-16960-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38922 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2A3MXm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jan 2012 07:23:42 -0500
In-Reply-To: <1327912546-16960-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chase Douglas <chase.douglas@canonical.com>

On 01/30/2012 10:35 AM, Henrik Rydberg wrote:

> +INPUT_PROP_BUTTONPAD:
> +--------------------
> +For touchpads where the button is placed under the touchpad, such as
> +clickpads and macbooks, this property should be set. Common in devices from
> +2009 and onwards.

"Under" can be interpreted to mean "under as in towards the user when 
looking from above" as well as "under as in towards the Earth's core". A 
more unambiguous description would be something like "For touchpads 
where a physical button is beneath the pad's touch surface so that 
pushing down on the touchpad causes a button click".

> +INPUT_PROP_SEMI_MT:
> +------------------
> +Some touchpads, most common between 2008 and 2011, can detect the presence
> +of multiple contacts without resolving the individual positions; only the
> +number of contacts and the corresponding bounding box is known. For such
> +touchpads, the semi-mt property should be set.

A "corresponding bounding box" usually means "a bounding box that 
contains all touches on the touchpad". I've been told (though I have not 
checked it myself) that there are devices that don't do this. They only 
report a bounding box for some subset of touches. If this is the case, 
it should be documented here.
