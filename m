From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 4/4] input: keyboard: tegra: remove default key mapping
Date: Fri, 04 Jan 2013 12:52:45 -0700
Message-ID: <50E7330D.2060107@wwwdotorg.org>
References: <1357297330-28878-1-git-send-email-ldewangan@nvidia.com> <1357297330-28878-5-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357297330-28878-5-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 01/04/2013 04:02 AM, Laxman Dewangan wrote:
> Tegra KBC driver have the default key mapping for 16x8 configuration.
> The key mapping can be provided through platform data or through DT
> and the mapping varies from platform to platform, hence this default
> mapping is not so useful. Remove the default mapping to reduce the code
> lines of the driver.

Overall, I agree with the intent of this change, but I /think/ the
default keymap described here actually /is/ useful for the
Seaboard/Springbank platforms. I guess the KBC driver isn't in the
device tree for that (or any) board yet, so removing this keymap isn't
really a regression, but it would be nice if you could come up with a
change to add suitable keymaps to the device tree files too.
