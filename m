From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3] leds: USB: HID: Add support for MSI GT683R led panels
Date: Wed, 11 Jun 2014 19:34:16 +0200
Message-ID: <20140611173416.GJ10256@localhost>
References: <CAEEjW06BnCiLyDDL82fjhFtwg5LyaGzKP+swzLFNKKwmZcvViQ@mail.gmail.com>
 <1402435299-16410-1-git-send-email-janne.kanniainen@gmail.com>
 <20140611140542.GG10256@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140611140542.GG10256@localhost>
Sender: linux-leds-owner@vger.kernel.org
To: Janne Kanniainen <janne.kanniainen@gmail.com>
Cc: jkosina@suse.cz, cooloney@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, johan@kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 11, 2014 at 04:05:42PM +0200, Johan Hovold wrote:
>
On Wed, Jun 11, 2014 at 12:21:39AM +0300, Janne Kanniainen wrote:
> > +static int gt683r_led_snd_msg(struct gt683r_led *led, char *msg)
> > +{
> > +	int ret;
> > +
> > +	ret = hid_hw_raw_request(led->hdev, 0x01, msg, GT683R_BUFFER_SIZE,
> > +				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> > +	if (ret < 0) {
> > +		hid_err(led->hdev,
> > +			"failed to send set report request: %i\n", ret);

And here's one more: You need to check if ret != GT683R_BUFFER_SIZE and
make sure to return an error (e.g. -EIO) even if ret >= 0 in that case.

> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}

Johan
