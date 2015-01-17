From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v18 00/12] input: cyapa: instruction of cyapa patches
Date: Sat, 17 Jan 2015 02:44:15 -0800
Message-ID: <20150117104415.GA2083@hudson.localdomain>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421390055-32760-1-git-send-email-dudl@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, bleung@google.com, dso@cypress.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dudley,

Your patch series applies without issue but unfortunately I
could not test them because I ran in to a bug created by someone
elses patch (not yours) [1].

  [1]: https://lkml.org/lkml/2015/1/17/24

Once that issue gets resolved I would be happy to test your patch
series.

On Fri, Jan 16, 2015 at 02:34:03PM +0800, Dudley Du wrote:
> V18 patches have below updates, details of other updates see history list:
> 1) Fix 'cyapa_runtime_suspend' undeclared compiling issue in latest
>    kernel-next source code. Verified on next-20150114 with make C=1.
> 2) Optimize enter bootloader failed for some chipset takes longer time issue.
[...]

-- 
- Jeremiah Mahler
