From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: hiddev: fix potential Spectre v1
Date: Fri, 26 Oct 2018 17:07:18 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810261707090.23511@cbobk.fhfr.pm>
References: <1539979293-16102-1-git-send-email-leitao@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1539979293-16102-1-git-send-email-leitao@debian.org>
Sender: stable-owner@vger.kernel.org
To: Breno Leitao <leitao@debian.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, gustavo@embeddedor.com, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 19 Oct 2018, Breno Leitao wrote:

> uref->usage_index can be indirectly controlled by userspace, hence leading
> to a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This field is used as an array index by the hiddev_ioctl_usage() function,
> when 'cmd' is either HIDIOCGCOLLECTIONINDEX, HIDIOCGUSAGES or
> HIDIOCSUSAGES.
> 
> For cmd == HIDIOCGCOLLECTIONINDEX case, uref->usage_index is compared to
> field->maxusage and then used as an index to dereference field->usage
> array. The same thing happens to the cmd == HIDIOC{G,S}USAGES cases, where
> uref->usage_index is checked against an array maximum value and then it is
> used as an index in an array.
> 
> This is a summary of the HIDIOCGCOLLECTIONINDEX case, which matches the
> traditional Spectre V1 first load:
> 
> 	copy_from_user(uref, user_arg, sizeof(*uref))
> 	if (uref->usage_index >= field->maxusage)
> 		goto inval;
> 	i = field->usage[uref->usage_index].collection_index;
> 	return i;
> 
> This patch fixes this by sanitizing field uref->usage_index before using it
> to index field->usage (HIDIOCGCOLLECTIONINDEX) or field->value in
> HIDIOC{G,S}USAGES arrays, thus, avoiding speculation in the first load.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Cc: <stable@vger.kernel.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
