From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 3/7] input: ti_am335x_tsc: Add variance filter
Date: Wed, 21 Nov 2012 10:33:50 -0800
Message-ID: <20121121183350.GB18950@core.coreip.homeip.net>
References: <1352271124-5513-1-git-send-email-rachna@ti.com>
 <1352271124-5513-4-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352271124-5513-4-git-send-email-rachna@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>
Cc: linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>
List-Id: linux-input@vger.kernel.org

Hi Rachna,

On Wed, Nov 07, 2012 at 12:22:00PM +0530, Patil, Rachna wrote:
> Only fine tuning variance parameter present in tslib
> utility does not help in removing all the ADC noise.
> This logic of filtering is necessary to get this
> touchscreen to work finely.

No, if filtering in tslib is not adequate please fix tslib so that your
work is usable for other devices as well.

Thanks.

-- 
Dmitry
