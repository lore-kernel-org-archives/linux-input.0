From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
	Arnaud  Patard.
Date: Thu, 19 Nov 2009 13:52:36 +0000
Message-ID: <20091119135236.GB5535@digital-scurf.org>
References: <20091118232939.201290297@fluff.org.uk>
	<20091118232948.063635416@fluff.org.uk>
	<20091119025930.GA20172@core.coreip.homeip.net>
	<4B052D50.2070002@simtec.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4B052D50.2070002@simtec.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-samsung-soc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 19, 2009 at 11:34:40AM +0000, Ben Dooks wrote:
>>> +		input_report_key(ts.input, BTN_TOUCH, 1);
>>> +		input_report_abs(ts.input, ABS_PRESSURE, 1);
>> No fake pressure events please, BTN_TOUCH should be enough.
> I'd have to check, IIRC tslib needs these to function properly.

Indeed it does -- otherwise it won't work.  Yes you could try going around and
patching TSLIB but so many people use it that it is principle-of-least-surprise
to produce pressure events.

>>> +	ts.input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
>>> +	input_set_abs_params(ts.input, ABS_X, 0, 0x3FF, 0, 0);
>>> +	input_set_abs_params(ts.input, ABS_Y, 0, 0x3FF, 0, 0);
>>> +	input_set_abs_params(ts.input, ABS_PRESSURE, 0, 1, 0, 0);
>> Drop ABS_PRESSURE.
> ok, see above.

The same applies here -- claim ABS_PRESSURE or tslib won't operate with the
touchscreen.

While it is tempting to be 100% exactly correct to what the hardware reports
(which is only TOUCH not PRESSURE) it is preferable to work with the software
which the majority of people use -- namely tslib.

I would strongly argue against removing the ABS_PRESSURE stuff personally,
despite it being essentially a lie.

Regards,

Daniel.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
