From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mark serio and i8042 as suspended
	when	hibernating too.
Date: Tue, 7 Jul 2009 23:54:36 -0700
Message-ID: <20090708065435.GF3309@dtor-d630.eng.vmware.com>
References: <1246760019-4120-1-git-send-email-cascardo@holoscopio.com>
	<200907070040.43299.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907070040.43299.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, linux-input@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, maciej.rutecki@gmail.com
List-Id: linux-input@vger.kernel.org

On Tue, Jul 07, 2009 at 12:40:42AM +0200, Rafael J. Wysocki wrote:
> On Sunday 05 July 2009, Thadeu Lima de Souza Cascardo wrote:
> > serio ports are not being restarted any longer because resume operations
> > after hibernate do nothing, since the device has not been marked as
> > suspended. This happens because suspend is only considering the SUSPEND
> > event but not the FREEZE event.
> > 
> > Note that this driver has still to migrate to dev_pm_ops, but this fixes
> > this particular bug now.
> 
> Hmm, this looks like a fix for:
> http://bugzilla.kernel.org/show_bug.cgi?id=13643
> 
> Any objections to merging it through the suspend tree?
> 

Oops, just applied it to mine before reading your mail... I hope Linus
will pick my pull request soon so it won't matter thoough.

-- 
Dmitry
