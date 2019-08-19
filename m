From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: wacom: Correct distance scale for 2nd-gen Intuos
 devices
Date: Mon, 19 Aug 2019 14:09:36 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908191409220.27147@cbobk.fhfr.pm>
References: <20190807051839.GA26833@kroah.com> <20190807211155.4280-1-jason.gerecke@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190807211155.4280-1-jason.gerecke@wacom.com>
Sender: stable-owner@vger.kernel.org
To: "Gerecke, Jason" <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 7 Aug 2019, Gerecke, Jason wrote:

> From: Jason Gerecke <jason.gerecke@wacom.com>
> 
> Distance values reported by 2nd-gen Intuos tablets are on an inverted
> scale (0 == far, 63 == near). We need to change them over to a normal
> scale before reporting to userspace or else userspace drivers and
> applications can get confused.
> 
> Ref: https://github.com/linuxwacom/input-wacom/issues/98
> Fixes: eda01dab53 ("HID: wacom: Add four new Intuos devices")
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Cc: <stable@vger.kernel.org> # v4.4+

Applied to for-5.3/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
