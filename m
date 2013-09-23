From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 1/1] Drivers: input: serio: New driver to support
 Hyper-V synthetic keyboard
Date: Mon, 23 Sep 2013 14:18:49 -0700
Message-ID: <9413886.ODbxHZ6JJT@dtor-d630.eng.vmware.com>
References: <1379460418-1523-1-git-send-email-kys@microsoft.com>
 <20130918210107.GA32320@core.coreip.homeip.net>
 <20130923210812.GA19953@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20130923210812.GA19953@aepfle.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Olaf Hering <olaf@aepfle.de>
Cc: gregkh@linuxfoundation.org, jasowang@redhat.com, linux-kernel@vger.kernel.org, vojtech@suse.cz, linux-input@vger.kernel.org, apw@canonical.com, devel@linuxdriverproject.org, dan.carpenter@oracle.com
List-Id: linux-input@vger.kernel.org

On Monday, September 23, 2013 11:08:12 PM Olaf Hering wrote:
> On Wed, Sep 18, Dmitry Torokhov wrote:
> > This looks much better. Could you tell me if the patch below (on top of
> > yours) still works?
> 
> The help text is slightly incorrect, its a dash not underscore:
> drivers/input/serio/hyperv-keyboard.ko

Module code converts all dashes to underscores if you check lsmod.

Thanks.

-- 
Dmitry
