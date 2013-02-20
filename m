From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 6/6] Input: Add ChromeOS EC keyboard driver
Date: Wed, 20 Feb 2013 10:21:35 -0800
Message-ID: <20130220182135.GC15152@core.coreip.homeip.net>
References: <1361381079-26747-1-git-send-email-sjg@chromium.org>
 <1361381079-26747-7-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361381079-26747-7-git-send-email-sjg@chromium.org>
Sender: linux-doc-owner@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Luigi Semenzato <semenzato@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Roland Stigge <stigge@antcom.de>, Wolfram Sang <w.sang@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 20, 2013 at 09:24:39AM -0800, Simon Glass wrote:
> +
> +			code = keycodes[pos];
> +			new_state = kb_state[col] & (1 << row);
> +			if (!!new_state != test_bit(code, idev->key)) {
> +				dev_dbg(ckdev->dev,
> +					"changed: [r%d c%d]: byte %02x\n",
> +					row, col, new_state);
> +
> +			input_report_key(idev, code, new_state);

Incorrect indentation.


> +			}

...

> +static int cros_ec_keyb_probe(struct platform_device *pdev)
> +{
> +	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = ec->dev;
> +	struct cros_ec_keyb *ckdev = NULL;
> +	struct input_dev *idev = NULL;

Why are we assigning these to NULL?

Otherwise

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
