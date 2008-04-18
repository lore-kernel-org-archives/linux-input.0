From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142
	joystick	driver (v2)
Date: Fri, 18 Apr 2008 13:15:58 -0400
Message-ID: <20080418131149.ZZRA012@mailhub.coreip.homeip.net>
References: <1206643110-8789-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1206643110-8789-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: andre-uV3PkZocewMvJ4zyQN8m6A@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Bryan,

On Thu, Mar 27, 2008 at 11:38:30AM -0700, Bryan Wu wrote:
> +	input->keybit[BIT_WORD(BTN_BASE)] = BIT_MASK(BTN_BASE) |
> +						BIT_MASK(BTN_BASE2) |
> +						BIT_MASK(BTN_BASE3) |
> +						BIT_MASK(BTN_BASE4);
> +	input->keybit[BIT_WORD(KEY_UP)] |=  BIT_MASK(KEY_UP) |
> +						BIT_MASK(KEY_DOWN) |
> +						BIT_MASK(KEY_LEFT) |
> +						BIT_MASK(KEY_RIGHT);
> +

Why don't you use REL_X/REL_Y to report directional movement? Using
buttons for that is pretty unusual.

-- 
Dmitry

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
