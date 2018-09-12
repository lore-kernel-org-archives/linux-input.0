From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 02/17] compat_ioctl: move drivers to
	generic_compat_ioctl_ptrarg
Date: Wed, 12 Sep 2018 20:13:38 +0200
Message-ID: <20180912181338.GD15031@kroah.com>
References: <20180912150142.157913-1-arnd@arndb.de>
	<20180912150142.157913-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180912150142.157913-2-arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, virtualization@lists.linux-foundation.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-mtd@lists.infradead.org, Peter Huewe <peterhuewe@gmx.de>, linux1394-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, Jason Gunthorpe <jgg@ziepe.ca>, Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>, Jiri Kosina <jikos@kernel.org>, viro@zeniv.linux.org.uk, Artem Bityutskiy <dedekind1@gmail.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 12, 2018 at 05:01:03PM +0200, Arnd Bergmann wrote:
> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
