Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060043D565D
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312740; cv=none; b=cDRVkUfO4qfiMBCMp/Gjiv8svamVVUtpXBfxGB6LFCHTHaa00QpznPAVViJ0sVq3Ei6lSC3Yf3tcYCBSYqhiHYL4/z3lMxcBIuADhPigOAnY9DFgU4xo0CbQd1T8ONpX+4ndbyD2f49s93Jo6ZpT8C4WtPvc+X4VIsrgu/WGs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312740; c=relaxed/simple;
	bh=gQT0Dh4w1FRsnGNXIf+ZAjjFe2JbvwsEarhaidrTAYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qrfO9e813jcf8zbWk+8o3jRrYs+7+F8HrEAEEZtgpsOy/KzGlU8nMLnx4AyjZB/kma/s3on6b7glfHIft7UW9HdHqBgecEBOm6g01RurlGeeWw6ymScCXglOVLCt4Brp7Hz7BSxm0VJaVpTFGrIAqdjgtOEg/Fka/rbAQa+5R3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMWk/WKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMWk/WKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275F71F000E9;
	Wed, 24 Jun 2026 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782312736;
	bh=u5Rpwg/dBcCUYg6dJFPoeoa3BbCgw+SAMnFOVGymUNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMWk/WKyNOZ+3mI9At+Pw2pX+UlBBQdnR7IYWaihRVyDnuxBoVkM6nVKBLQFjpIP0
	 fvCt7RpttL5120twS1zvhQKdUKSUOt0mdkSynzIrMTgly3miQeJU1bLBSDm1bH73R/
	 HzppKj22BuW0j54kzd5Wp2LyyjkaIO4BiXgRpB22LWdRopoTat/XJhNzK1xQoYkxMv
	 MnILEMCFKtCawF04AjijzvP6FcKMibM2rJTEvrH8MjMKjBCqG6h9cDpyrcfbFt+aWL
	 utLbve9Cr/J3Tqa5Hss2js7+xc+e63dSqC/QyUwuGPhfywz2Hq99TTejAyi/pU39jC
	 1d1tF1XwPeXjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: amd_sfh: return an error when response wait times
 out
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
References: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:52:15 +0000
Message-Id: <20260624145216.275F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The timeout error codes returned by the patch are silently discard=
ed, rendering the fix ineffective.

Pre-existing issues:
- [High] Data race on the shared cli_data->cur_hid_dev variable causes spur=
ious timeouts and missed wakeups.
- [High] A timeout in amdtp_wait_for_response leaves a stalled request in t=
he queue, permanently desynchronizing the state machine.
--

commit e8a7b9fc56953c32e53def387e9ca9eac4750f78
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

HID: amd_sfh: return an error when response wait times out
   =20
amdtp_wait_for_response() waits for request_done before completing a
report request. wait_event_interruptible_timeout() returns 0 when the
wait expires, but the current code treats only negative values as errors
and returns success on timeout. This commit returns -ETIMEDOUT when the
response wait expires.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-=
hid/amd_sfh_hid.c
> index b04f675d49b0d..8f88f965fbd55 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> @@ -87,16 +87,17 @@ static int amdtp_wait_for_response(struct hid_device =
*hid)
>  			break;
>  	}
> =20
> -	if (!cli_data->request_done[i])
> +	if (!cli_data->request_done[i]) {
>  		ret =3D wait_event_interruptible_timeout(hid_data->hid_wait,
>  						       cli_data->request_done[i],
>  						       msecs_to_jiffies(AMD_SFH_RESPONSE_TIMEOUT));
> -	if (ret =3D=3D -ERESTARTSYS)
> -		return -ERESTARTSYS;
> -	else if (ret < 0)
> -		return -ETIMEDOUT;
> -	else
> -		return 0;
> +		if (ret =3D=3D -ERESTARTSYS)
> +			return -ERESTARTSYS;
> +		if (ret <=3D 0)
> +			return -ETIMEDOUT;

[Severity: High]
The patch returns -ETIMEDOUT here, but amdtp_wait_for_response() is registe=
red
as the .wait callback in struct hid_ll_driver.

When called via the wrapper hid_hw_wait(), the return value is discarded:

include/linux/hid.h:hid_hw_wait()
static inline void hid_hw_wait(struct hid_device *hdev)
{
        if (hdev->ll_driver->wait)
                hdev->ll_driver->wait(hdev);
}

Does this mean the caller (HID core) never sees the error code and proceeds=
 as
if the wait succeeded?

[Severity: High]
This isn't a bug introduced by this patch, but if this times out, does it
leave a stalled request in the queue?

In amd_sfh_get_report(), requests are queued to cli_data->req_list. If we
exit here, the request node isn't removed. Later, amd_sfh_work() pops and
processes it:

drivers/hid/amd-sfh-hid/amd_sfh_client.c:amd_sfh_work()
        req_node =3D list_last_entry(&req_list->list, struct request_list, =
list);
        list_del(&req_node->list);

Will this cause the background worker to process timed-out requests and
prematurely wake up future requests with stale data, permanently
desynchronizing the request queue?

> +	}
> +
> +	return 0;
>  }
> =20
>  void amdtp_hid_wakeup(struct hid_device *hid)
>  {
>  	struct amdtp_hid_data *hid_data;
>  	struct amdtp_cl_data *cli_data;
> =20
>  	if (hid) {
>  		hid_data =3D hid->driver_data;
>  		cli_data =3D hid_data->cli_data;
>  		cli_data->request_done[cli_data->cur_hid_dev] =3D true;

[Severity: High]
This is a pre-existing issue, but is there a data race on
cli_data->cur_hid_dev?

amd_sfh_set_report() updates cur_hid_dev locklessly:

drivers/hid/amd-sfh-hid/amd_sfh_client.c:amd_sfh_set_report()
    cli_data->cur_hid_dev =3D i;

If a SET_REPORT request is issued concurrently with a GET_REPORT worker, co=
uld
cur_hid_dev be overwritten, causing amdtp_hid_wakeup() to set request_done =
for
the wrong device index and leaving the original device's waiter to permanen=
tly
time out?

>  		wake_up_interruptible(&hid_data->hid_wait);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624143558.3930=
6-1-pengpeng@iscas.ac.cn?part=3D1
