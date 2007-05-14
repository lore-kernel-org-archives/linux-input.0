From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [patch 0/2] [PATCH] input: correctly handle keys without hardware release event
Date: Sun, 13 May 2007 23:44:18 -0400
Message-ID: <200705132344.19311.dtor@insightbb.com>
References: <20070511172326.008944330@caffeinetrip.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759374AbXENDo3@vger.kernel.org>
In-Reply-To: <20070511172326.008944330@caffeinetrip.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Giel de Nijs <giel@caffeinetrip.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Matt Domsch <matt_domsch@dell.com>, Rezwanul Kabir <rezwanul_kabir@dell.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Giel,

On Friday 11 May 2007 13:23, Giel de Nijs wrote:
> Hi,
> 
> This patch adds a soft release key mask to input_dev, to enable keyboard
> drivers to determine which keys never generate a hardware release event and
> hence add a release event after every press event of such keys. The mask is
> controlled by ioctls.

I don't think we want to add all the infrastructure for the benefit of single
driver. Can we add a quirk to atkbd and activate it based on DMI?

-- 
Dmitry
