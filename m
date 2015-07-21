From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 3/7] input: cyapa: add proximity function support for
 gen5 and gen6 modules
Date: Mon, 20 Jul 2015 17:06:58 -0700
Message-ID: <20150721000658.GD15528@dtor-ws>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
 <1434358897-24668-4-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434358897-24668-4-git-send-email-dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dudley,

On Mon, Jun 15, 2015 at 05:01:33PM +0800, Dudley Du wrote:
>  
> +static void cyapa_pip_report_proximity(struct cyapa *cyapa,
> +		const struct cyapa_pip_report_data *report_data)
> +{
> +	struct input_dev *input = cyapa->input;
> +	u8 distance = report_data->report_head[PIP_PROXIMITY_DISTANCE_OFFSET] &
> +			PIP_PROXIMITY_DISTANCE_MASK;
> +
> +	input_report_abs(input, ABS_MT_DISTANCE, distance);
> +	input_sync(input);

It looks like the distance reported by the hardware is not per-contact
(i.e. it can not tell that we had 2 fingers on surface and the 2nd one
was lifted and is now hovering over the surface), so we should be using
ABS_DISTANCE, not ABS_MT_DISTANCE.

I can adjust it here, no need to resend.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
