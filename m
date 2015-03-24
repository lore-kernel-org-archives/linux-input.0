From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Tue, 24 Mar 2015 10:01:00 -0700
Message-ID: <20150324170100.GB11352@dtor-ws>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
 <550FFB84.6000609@redhat.com>
 <201503231802.28977@pali>
 <551111E1.6090303@redhat.com>
 <CAPXTYCXrvFDbvEDkEQxkcJ5y1OHx7Ldm+bu-LnWfigjTj6gECw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPXTYCXrvFDbvEDkEQxkcJ5y1OHx7Ldm+bu-LnWfigjTj6gECw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santiago Gala <sgala@apache.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 24, 2015 at 10:25:13AM +0000, Santiago Gala wrote:
> I can't compile the  kernel in this laptop, sorry, I tried but couln't
> complete: it requires too much free disk (more than 9GB) and the SSD is
> very small.
> 
> If there is a way (I have not found it even though I know that dkms exists)
> to just compile the modjule I could easily test the patch with the mainline
> ubuntu binary of the relevant 4.0.0-rcN, but spending some time trying it
> didn't show how to do i

If you have another more powerful box you can always compile the kernel
there and then use "sshfs -o allow_others local_dir
remote_box:kernel/build/dir/" to mount the build directory on the target
box and do "cd local_dir; sudo make modules_install install" to install
the kernel.

Thanks.

-- 
Dmitry
