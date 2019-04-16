From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3 09/26] compat_ioctl: move drivers to
 compat_ptr_ioctl
Date: Tue, 16 Apr 2019 22:31:24 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1904162230560.9803@cbobk.fhfr.pm>
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202013.4034148-10-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190416202013.4034148-10-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgg@mellanox.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Tomas Winkler <tomas.winkler@intel.com>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@inf>
List-Id: linux-input@vger.kernel.org

On Tue, 16 Apr 2019, Arnd Bergmann wrote:

> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/ppdev.c              | 12 +---------
>  drivers/char/tpm/tpm_vtpm_proxy.c | 12 +---------
>  drivers/firewire/core-cdev.c      | 12 +---------
>  drivers/hid/usbhid/hiddev.c       | 11 +--------

For hiddev.c:

Reviewed-by: Jiri Kosina <jkosina@suse.cz> 

-- 
Jiri Kosina
SUSE Labs
