From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH resend] N-Trig: change default value of logical/physical
 width/height to 1
Date: Tue, 25 Sep 2012 08:00:36 -0400
Message-ID: <50619CE4.2020604@seas.upenn.edu>
References: <1347956828-5967-1-git-send-email-jesse.sung@canonical.com> <1348570267-15322-1-git-send-email-jesse.sung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:50478 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab2IYMKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Sep 2012 08:10:10 -0400
In-Reply-To: <1348570267-15322-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jesse Sung <jesse.sung@canonical.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/25/12 06:51, Jesse Sung wrote:
> From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> 
> Since something will be divided by these variables in 
> show_min_width()/show_min_height() and show_activate_width()/ 
> show_activate_height(), a divided error would be triggered if they are
> zero.

Fair point about the divide by zero.  Would it be preferable to use real
values.  As far as I know these devices all have logical dimensions of
9600x7200.  Unfortunately both logical and physical are used as denominators,
so 1 for the physicals is probably sensible.

Rafi

> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com> --- 
> drivers/hid/hid-ntrig.c |    8 ++++---- 1 file changed, 4 insertions(+), 4
> deletions(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c index
> 9fae2eb..86a969f 100644 --- a/drivers/hid/hid-ntrig.c +++
> b/drivers/hid/hid-ntrig.c @@ -882,10 +882,10 @@ static int
> ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id) 
> nd->activate_slack = activate_slack; nd->act_state = activate_slack; 
> nd->deactivate_slack = -deactivate_slack; -	nd->sensor_logical_width = 0; -
> nd->sensor_logical_height = 0; -	nd->sensor_physical_width = 0; -
> nd->sensor_physical_height = 0; +	nd->sensor_logical_width = 1; +
> nd->sensor_logical_height = 1; +	nd->sensor_physical_width = 1; +
> nd->sensor_physical_height = 1;
> 
> hid_set_drvdata(hdev, nd);
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQYZzbAAoJEPILXytRLnK2BSsQAKYxIDoQ8iaIIcHUw0s8mKr5
X1A6dP8LUgWqy0NyKvlfSKwcVra67XHjKWONpgHC3nEoVVxw14Kb41TjQPeBNZrS
Ua+NRH7v3kO+SaV6rS+ns3vGoY5zTlk3Ixbtso3XhF7PmM/BoOk93TNB136q61tx
JJgnLsusvjk+OWwrcTaBY2jb4aR6qUnUlz0VkaNdv4Da/Q0t3XBKRiaVfgFWk5PX
YyYUTDqK95/GHk/GF7ibU0FJz/H9imIHGfl/xxgiwt1KFaM2cKIfI4/2DRy1Wu4G
RRZ/++TeWUmonTAZnhrsHYchaYvnfobK5zK2TtkgGFQINCc6SaekAXEwfIHaA4wJ
VgYP40tT2WaMnpQO+lGCRMPdL6UBKHW0oRDYr6n/dk0KNw5rccIVxQ2a/PIX5Me9
u0dKQ35Fv4c1XoIpxSvZEjWnirbmhxTtT8Y5U4yd32H+Eic3tG73nhYApcuNvuzj
TNveK1iOgJCVOBX9/7byFVQKFTGWt3JyBo4FGqWbbmpAK6wMQbxRjcoC4u2bHp7r
B8/m+kGqBHzqGibDiJh56g/xbOz21fKnuQ4Kk1j5v6t2fyQbfmfR7LlRWK3qI8/O
yDhGIikrzEqIrwALI9idTRdJGBNsbhWu//VFll3xAVE29qbxzWF37xSwficyuCtc
Yg7IvGqcmn4S0ymCyTKx
=zBAE
-----END PGP SIGNATURE-----
