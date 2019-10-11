From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v7 2/8] efi: Add embedded peripheral firmware support
Date: Fri, 11 Oct 2019 14:48:34 +0000
Message-ID: <20191011144834.GL16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-3-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:50PM +0200, Hans de Goede wrote:
> +static int __init efi_check_md_for_embedded_firmware(
> +	efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
> +{
> +	const u64 prefix = *((u64 *)desc->prefix);
> +	struct sha256_state sctx;
> +	struct embedded_fw *fw;
> +	u8 sha256[32];
> +	u64 i, size;
> +	void *map;
> +
> +	size = md->num_pages << EFI_PAGE_SHIFT;
> +	map = memremap(md->phys_addr, size, MEMREMAP_WB);

Since our limitaiton is the init process must have mostly finished,
it implies early x86 boot code cannot use this, what measures can we
take to prevent / check for such conditions to be detected and
gracefully errored out?

> +	if (!map) {
> +		pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
> +		return -ENOMEM;
> +	}
> +
> +	size -= desc->length;

Remind me again, why we decrement the size here?
I was going to ask if we didn't need a:

if (desc->length > size) {
	memunmap(map);
	return -EINVAL;
}

> +	for (i = 0; i < size; i += 8) {
> +		u64 *mem = map + i;
> +
> +		if (*mem != prefix)
> +			continue;
> +
> +		sha256_init(&sctx);
> +		sha256_update(&sctx, map + i, desc->length);
> +		sha256_final(&sctx, sha256);
> +		if (memcmp(sha256, desc->sha256, 32) == 0)
> +			break;
> +	}
> +	if (i >= size) {
> +		memunmap(map);
> +		return -ENOENT;
> +	}
> +
> +	pr_info("Found EFI embedded fw '%s'\n", desc->name);

Otherwise looks good.

  Luis
