From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCHv16 10/13] cec: adv7842: add cec support
Date: Thu, 16 Jun 2016 18:22:28 -0300
Message-ID: <20160616182228.1bd755d5@recife.lan>
References: <1461937948-22936-1-git-send-email-hverkuil@xs4all.nl>
	<1461937948-22936-11-git-send-email-hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1461937948-22936-11-git-send-email-hverkuil@xs4all.nl>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

Em Fri, 29 Apr 2016 15:52:25 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> From: Hans Verkuil <hans.verkuil@cisco.com>
> 
> Add CEC support to the adv7842 driver.
> 
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>

Won't review patches 10-13, as the same reviews I made for patch 9
very likely applies.

As this series is causing non-staging drivers to be dependent of a
staging driver, I'll wait for the next version that should be
solving this issue.

For the new 9-13 patches, please be sure that checkpatch will be
happy. For the staging stuff, the checkpatch issues can be solved
later, as I'll re-check against checkpatch when it moves from staging
to mainstream.

Regards,
Mauro

Thanks,
Mauro
