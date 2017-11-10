From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 3/3] HID: cp2112: fix broken gpio_direction_input
 callback
Date: Fri, 10 Nov 2017 13:33:42 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711101333310.32604@cbobk.fhfr.pm>
References: <1510304503-30830-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510304503-30830-1-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Julien Boibessot <julien.boibessot@armadeus.com>
List-Id: linux-input@vger.kernel.org

On Fri, 10 Nov 2017, Sébastien Szymanski wrote:

> When everything goes smoothly, ret is set to 0 which makes the function
> to return EIO error.
> 
> Fixes: 8e9faa15469e ("HID: cp2112: fix gpio-callback error handling")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
> Changes in v2:
>  - rework error handling to have only one exit path as suggested by
>    Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.15/upstream.

-- 
Jiri Kosina
SUSE Labs
