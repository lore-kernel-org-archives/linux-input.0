From: "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
Subject: RE: [PATCH V1] da9052: ONKEY: use correct register bit for key
 status
Date: Tue, 11 Feb 2014 16:57:47 +0000
Message-ID: <24DF37198A1E704D9811D8F72B87EB51BCFD52F3@NB-EX-MBX02.diasemi.com>
References: <201402111610.s1BGAXJo056493@swsrvapps-02.lan>
 <20140211162857.GA12106@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140211162857.GA12106@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>
List-Id: linux-input@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 11 February 2014 16:29
..[snip]..
> >  static void da9052_onkey_query(struct da9052_onkey *onkey)  {
> > -	int key_stat;
> > +	int ret, key_stat;
> >
> > -	key_stat = da9052_reg_read(onkey->da9052,
> DA9052_EVENT_B_REG);
> > -	if (key_stat < 0) {
> > +	ret = da9052_reg_read(onkey->da9052, DA9052_STATUS_A_REG);
> > +	if (ret < 0) {
> >  		dev_err(onkey->da9052->dev,
> > -			"Failed to read onkey event %d\n", key_stat);
> > +			"Failed to read onkey event err=%d\n", ret);
> > +		key_stat = false;
> 
> Why do you need this assignment? Also, key_stat is integer, why are we
> using boolean values for it?
> 
> >  	} else {
> >  		/*
> >  		 * Since interrupt for deassertion of ONKEY pin is not
> >  		 * generated, onkey event state determines the onkey
> >  		 * button state.
> >  		 */
> > -		key_stat &= DA9052_EVENTB_ENONKEY;
> > +		if (ret & DA9052_STATUSA_NONKEY)
> > +			key_stat = false;
> > +		else
> > +			key_stat = true;
> 
> It seems to me that the relevant changes are replacement of
> DA9052_EVENT_B_REG -> DA9052_STATUS_A_REG in da9052_reg_read()
> and doing:
> 
> 		key_stat &= DA9052_STATUSA_NONKEY;
> 		input_report_key(onkey->input, KEY_POWER, !key_stat);
> 
> Right?

Right as far as the register and the bit within it.

However, should the register read fail due to the PMIC not responding on the i2c bus then the previous code would just loop round the work queue.
By explicitly using key_stat as a boolean it makes the code very clear that in the case of failure a 'false' value is set. As it was the negative value of the error code would be treated as true, since -EFAULT being non-zero will be treated as true.

Tony Olech

> Thanks.
> Dmitry
