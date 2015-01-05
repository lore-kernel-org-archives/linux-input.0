From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - switch ForcePad detection to PNP IDs
Date: Mon, 5 Jan 2015 10:39:18 -0500
Message-ID: <20150105153918.GF19391@mail.corp.redhat.com>
References: <20141229225113.GA13847@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbbAEPj1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Jan 2015 10:39:27 -0500
Content-Disposition: inline
In-Reply-To: <20141229225113.GA13847@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-kernel@vger.kernel.org

On Dec 29 2014 or thereabouts, Dmitry Torokhov wrote:
> According to Synaptics devices with ForcePads use SYN300D and SYN3014 as
> PNP IDs, so let's switch from DMI-bases detection scheme to PNP-based
> one, which should be more reliable.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good to me too:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

