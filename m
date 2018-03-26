From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
Date: Mon, 26 Mar 2018 17:24:46 -0500
Message-ID: <20180326222446.spjzqqgiujadd3zm@rob-hp-laptop>
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tirupathi Reddy <tirupath@codeaurora.org>
Cc: dmitry.torokhov@gmail.com, bjorn.andersson@linaro.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 23, 2018 at 11:53:12AM +0530, Tirupathi Reddy wrote:
> Add resin key support to handle different types of key events
> defined in different platforms.
> 
> Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
> ---
>  .../bindings/input/qcom,pm8941-pwrkey.txt          | 32 +++++++++

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/input/misc/pm8941-pwrkey.c                 | 81 ++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
