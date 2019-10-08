From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
Date: Tue, 8 Oct 2019 13:05:12 +0200
Message-ID: <20191008110512.GA116541@gmail.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191007141956.GA25347@gmail.com>
 <c7f1678f-ff03-1c3a-02e3-a68025b87969@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c7f1678f-ff03-1c3a-02e3-a68025b87969@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> > So I was looking for a high level 0/ boilerplate description of this
> > series, to explain what "EFI embedded fw" is, what problems it solves and
> > how it helps the kernel in general - and found this in 2/8:
> 
> Sorry you had to dig into the individual patch changelogs for that
> I sorta assumed that everyone involved would still vaguely remember
> what this series is about.

Wasn't *that* hard to do and I intended to read the patches anyway. ;-)

Thanks for the explanation and the answers, this all looks good to me in 
principle and in implementation as well.

Thanks,

	Ingo
